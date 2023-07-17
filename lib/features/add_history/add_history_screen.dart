import 'package:hifz_tracker_teacher/controllers/add_history_controller.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class AddHistoryScreen extends GetView<AddHistoryController> {
  const AddHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(title: 'Tambah riwayat'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.addKey,
          child: Obx(
            () => ListView(
              children: [
                Row(
                  children: [
                    _buildChip(controller: controller, label: 'Hafalan'),
                    const SizedBox(
                      width: 16,
                    ),
                    _buildChip(controller: controller, label: 'Murroja\'ah'),
                  ],
                ),
                const SizedBox(height: 16),
                CustomLabeledDropdown(
                  selectedValue: controller.selectedSurah.value,
                  label: 'Pilih Surat',
                  items: controller.surahNames.value,
                  onSelect: (value) => controller.selectedSurah(value),
                ),
                const SizedBox(height: 16),
                CustomLabeledTextFormField(
                  label: 'Dari ayat',
                  controller: controller.fromAyatCtr,
                  textInputType: TextInputType.number,
                ),
                CustomLabeledTextFormField(
                  label: 'Sampai ayat',
                  controller: controller.toAyatCtr,
                  textInputType: TextInputType.number,
                ),
                CustomLabeledTextFormField(
                  label: 'Tanggal',
                  controller: controller.dateCtr,
                  readOnly: true,
                  onTap: () => _showDatePicker(context: context),
                ),
                CustomLabeledTextFormField(
                  label: 'Jam',
                  controller: controller.timeCtr,
                  readOnly: true,
                  onTap: () => _showTimePicker(context: context),
                ),
                CustomLabeledDropdown(
                  label: 'Nilai',
                  items: controller.grades,
                  onSelect: (value) => controller.selectedGrade(value),
                  labelStyle: const TextStyle(fontWeight: FontWeight.normal),
                  selectedValue: controller.selectedGrade.value,
                  borderRadius: 8,
                  bgColor: Colors.white,
                ),
                const SizedBox(height: 12),
                CustomLabeledTextFormField(
                  label: 'Review',
                  controller: controller.reviewCtr,
                  textInputType: TextInputType.multiline,
                ),
                CheckboxListTile(
                  value: controller.isFluent.value,
                  onChanged: (value) => controller.isFluent(value),
                  title: const Text('Hafalan Lancar'),
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomElevatedButton(
                  text: 'Tambah',
                  onPressed: () => controller.addHistory(),
                  borderRadius: 16,
                  isLoading: controller.isLoading.value,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ChoiceChip _buildChip(
      {required AddHistoryController controller, required String label}) {
    return ChoiceChip(
      label: Text(
        label,
        style: controller.selectedType.value == label
            ? CustomTextStyle.white()
            : CustomTextStyle.black(),
      ),
      selected: controller.selectedType.value == label,
      onSelected: (value) => controller.selectedType(label),
      selectedColor: CustomColor.primaryColor,
    );
  }

  _showDatePicker({required BuildContext context}) async {
    final initialDate =
        DateFormat('dd MMMM yyyy', 'id_ID').parse(controller.dateCtr.text);
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1990),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      final formattedDate =
          DateFormat('dd MMMM yyyy', 'id_ID').format(selectedDate);
      controller.dateCtr.text = formattedDate;
    }
  }

  _showTimePicker({required BuildContext context}) async {
    final splittedTime = controller.timeCtr.text.split(':');
    final hour = splittedTime.first;
    final minute = splittedTime.last;

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(hour),
        minute: int.parse(minute),
      ),
    );

    if (selectedTime != null) {
      final hour = selectedTime.hour.toString().padLeft(2, '0');
      final minute = selectedTime.minute.toString().padLeft(2, '0');

      controller.timeCtr.text = '$hour:$minute';
    }
  }
}
