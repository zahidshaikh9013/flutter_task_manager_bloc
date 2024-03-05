import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manage_app/app/manager/colors.dart';
import 'package:task_manage_app/app/manager/dimension.dart';
import 'package:task_manage_app/app/manager/strings.dart';
import 'package:task_manage_app/app/utils/app_utils.dart';
import 'package:task_manage_app/domain/model/task_model.dart';
import 'package:task_manage_app/presentation/main/task/bloc/task_cubit.dart';
import 'package:task_manage_app/presentation/widgets/button_widget.dart';
import 'package:task_manage_app/presentation/widgets/text_field_widget.dart';

class CrudTaskScreen extends StatefulWidget {
  final TaskModel? task;

  const CrudTaskScreen({super.key, this.task});

  @override
  State<CrudTaskScreen> createState() => CrudTaskScreenState();
}

class CrudTaskScreenState extends State<CrudTaskScreen> {
  final txtTitle = TextEditingController();
  final txtDescription = TextEditingController();
  final txtDateTime = TextEditingController();
  DateTime selectedTime = DateTime.now();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool? isValidate;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      txtTitle.text = widget.task?.title ?? "";
      txtDescription.text = widget.task?.description ?? "";
      selectedTime = widget.task?.createdAt ?? DateTime.now();
      txtDateTime.text = DateFormat(AppUtils.ddMMMyyyy).format(selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? Strings.addTaskText : Strings.updateTaskText),
        backgroundColor: AppColor.primaryColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        leading: const BackButton(color: Colors.white),
      ),
      body: Form(
        key: globalKey,
        autovalidateMode: isValidate != null ? AutovalidateMode.onUserInteraction : null,
        child: ListView(
          padding: Dimensions.p16,
          children: [
            _hintText(Strings.titleText),
            Dimensions.h5,
            _titleTextField(),
            Dimensions.h20,
            _hintText(Strings.descriptionText),
            Dimensions.h5,
            _descriptionTextField(),
            Dimensions.h20,
            _hintText(Strings.datetimeText),
            Dimensions.h5,
            _datetimeField(),
            Dimensions.h40,
            _submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return FilledButtons(
      text: widget.task == null ? Strings.addTaskText : Strings.updateTaskText,
      onTap: onSubmitClick,
    );
  }

  Widget _hintText(String title) {
    return Text(
      title,
      style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w600),
    );
  }

  Widget _titleTextField() {
    return TextFormFieldWidget(
      controller: txtTitle,
      hintText: Strings.titleText,
      prefixIcon: const Icon(Icons.title, color: AppColor.primaryColor),
      validator: (value) {
        if (value?.trim().isEmpty == true) {
          return Strings.requiredFiledText;
        }
        return null;
      },
    );
  }

  Widget _descriptionTextField() {
    return TextFormFieldWidget(
      controller: txtDescription,
      hintText: Strings.descriptionText,
      minLines: 5,
      maxLines: 5,
      validator: (value) {
        if (value?.trim().isEmpty == true) {
          return Strings.requiredFiledText;
        }
        return null;
      },
    );
  }

  Widget _datetimeField() {
    return TextFormFieldWidget(
      controller: txtDateTime,
      hintText: Strings.datetimeText,
      readOnly: true,
      onFieldTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
          initialDate: selectedTime,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColor.primaryColor, // header background color
                  onPrimary: AppColor.whiteColor, // header text color
                  onSurface: AppColor.blackColor, // body text color
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          selectedTime = date;
          txtDateTime.text = DateFormat("dd MMMM, yyyy").format(date);
          setState(() {});
        }
      },
      prefixIcon: const Icon(
        Icons.date_range,
        color: AppColor.primaryColor,
      ),
      validator: (value) {
        if (value?.trim().isEmpty == true) {
          return Strings.requiredFiledText;
        }
        return null;
      },
    );
  }

  void onSubmitClick() async {
    if (globalKey.currentState!.validate()) {
      final task = TaskModel(
        id: widget.task?.id,
        title: txtTitle.text.trim(),
        status: TaskStatusEnum.pending,
        description: txtDescription.text,
        createdAt: selectedTime,
      );
      bool result = false;
      if (widget.task != null) {
        result = await context.read<TaskCubit>().updateTask(taskModel: task);
      } else {
        result = await context.read<TaskCubit>().insertTask(taskModel: task);
      }
      if (result) {
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Strings.oopsErrorPleaseTryLater,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColor.redColor,
          ),
        );
      }
    }
    isValidate = true;
    setState(() {});
  }
}
