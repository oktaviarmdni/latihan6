import 'package:flutter/material.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  _CompleteRadioButtonFormState createState() =>
      _CompleteRadioButtonFormState();
}

class _CompleteRadioButtonFormState extends State<RadiobuttonPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();

  String? _selectedGender;
  String? _selectedJob;
  String? _selectedWorkType;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _jobOptions = [
    {
      'value': 'Admin',
      'icon': Icons.support_agent,
      'color': const Color(0xFF2196F3),
      'description': 'Mengelola Data',
    },
    {
      'value': 'Guru',
      'icon': Icons.school,
      'color': const Color(0xFF9C27B0),
      'description': 'Mendidik generasi',
    },
    {
      'value': 'Programmer',
      'icon': Icons.code,
      'color': const Color(0xFF4CAF50),
      'description': 'Mengembangkan software',
    },
    {
      'value': 'Pengusaha',
      'icon': Icons.business,
      'color': const Color(0xFFFF9800),
      'description': 'Mengelola bisnis',
    },
    {
      'value': 'Desainer',
      'icon': Icons.design_services,
      'color': const Color(0xFF00BCD4),
      'description': 'Kreativitas visual',
    },
  ];

  final List<Map<String, dynamic>> _workTypeOptions = [
    {
      'value': 'Full Time',
      'subtitle': 'Bekerja 40 jam/minggu',
      'icon': Icons.work,
      'color': const Color(0xFF00897B),
      'benefits': ['Asuransi kesehatan', 'Tunjangan hari raya'],
    },
    {
      'value': 'Part Time',
      'subtitle': 'Bekerja < 40 jam/minggu',
      'icon': Icons.access_time,
      'color': const Color(0xFF0288D1),
      'benefits': ['Jadwal fleksibel', 'Liburan panjang'],
    },
    {
      'value': 'Freelance',
      'subtitle': 'Pekerja lepas',
      'icon': Icons.laptop,
      'color': const Color(0xFF7B1FA2),
      'benefits': ['Kerja remote', 'Rate per project'],
    },
    {
      'value': 'Kontrak',
      'subtitle': 'Perjanjian waktu tertentu',
      'icon': Icons.description,
      'color': const Color(0xFFE65100),
      'benefits': ['Bonus kontrak', 'Evaluasi berkala'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _namaController.dispose();
    _umurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Form dengan RadioButton',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF00695C), Color(0xFF00897B)],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- SECTION: DATA DIRI ---
                _buildModernSection('Data Diri', Icons.person_outline, [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildModernTextField(
                            controller: _namaController,
                            label: 'Nama Lengkap',
                            hint: 'Masukkan nama lengkap Anda',
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Nama tidak boleh kosong';
                              if (value.length < 3)
                                return 'Nama minimal 3 karakter';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildModernTextField(
                            controller: _umurController,
                            label: 'Umur',
                            hint: 'Masukkan umur Anda',
                            icon: Icons.cake_outlined,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Umur tidak boleh kosong';
                              int? age = int.tryParse(value);
                              if (age == null || age < 17 || age > 100)
                                return 'Umur harus antara 17-100 tahun';
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),

                const SizedBox(height: 24),

                // --- SECTION: JENIS KELAMIN ---
                _buildModernSection('Jenis Kelamin', Icons.people_outline, [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FormField<String>(
                        validator: (value) => value == null || value.isEmpty
                            ? 'Jenis kelamin harus dipilih'
                            : null,
                        builder: (FormFieldState<String> state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildGenderOption(
                                      title: 'Laki-laki',
                                      value: 'Laki-laki',
                                      icon: Icons.male,
                                      color: const Color(0xFF2196F3),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF64B5F6),
                                          Color(0xFF1976D2),
                                        ],
                                      ),
                                      state: state,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildGenderOption(
                                      title: 'Perempuan',
                                      value: 'Perempuan',
                                      icon: Icons.female,
                                      color: const Color(0xFFE91E63),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFF06292),
                                          Color(0xFFC2185B),
                                        ],
                                      ),
                                      state: state,
                                    ),
                                  ),
                                ],
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    top: 12,
                                  ),
                                  child: _buildErrorText(state.errorText!),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ]),

                const SizedBox(height: 24),

                // --- SECTION: PEKERJAAN ---
                _buildModernSection('Pekerjaan', Icons.work_outline, [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: FormField<String>(
                        validator: (value) => value == null || value.isEmpty
                            ? 'Pekerjaan harus dipilih'
                            : null,
                        builder: (FormFieldState<String> state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: _jobOptions.asMap().entries.map((
                                  entry,
                                ) {
                                  int index = entry.key;
                                  var job = entry.value;
                                  return _buildAnimatedChoiceChip(
                                    job: job,
                                    isSelected: _selectedJob == job['value'],
                                    index: index,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedJob = selected
                                            ? job['value']
                                            : null;
                                        state.didChange(_selectedJob);
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: _buildErrorText(state.errorText!),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ]),

                const SizedBox(height: 24),

                // --- SECTION: TIPE PEKERJAAN ---
                _buildModernSection(
                  'Tipe Pekerjaan',
                  Icons.business_center_outlined,
                  [
                    FormField<String>(
                      validator: (value) => value == null || value.isEmpty
                          ? 'Tipe pekerjaan harus dipilih'
                          : null,
                      builder: (FormFieldState<String> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._workTypeOptions.map(
                              (work) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildModernWorkTile(
                                  work: work,
                                  groupValue: _selectedWorkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedWorkType = value;
                                      state.didChange(value);
                                    });
                                  },
                                ),
                              ),
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: _buildErrorText(state.errorText!),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // --- SECTION: TOMBOL SUBMIT & RESET ---
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildGradientButton(
                        onPressed: _submitForm,
                        text: 'Simpan Data',
                        icon: Icons.save,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00695C), Color(0xFF00897B)],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _buildOutlineButton(
                        onPressed: _resetForm,
                        text: 'Reset',
                        icon: Icons.refresh,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // HELPER WIDGETS (Berdasarkan Screenshot)
  // =========================================================================

  Widget _buildModernSection(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF00897B), size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37474F),
                ),
              ),
            ],
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF00897B)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF00897B), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE53935)),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildGenderOption({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required LinearGradient gradient,
    required FormFieldState<String> state,
  }) {
    bool isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedGender = value);
        state.didChange(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: isSelected ? color : Colors.grey),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? color : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedChoiceChip({
    required Map<String, dynamic> job,
    required bool isSelected,
    required int index,
    required Function(bool) onSelected,
  }) {
    Color color = job['color'];
    return InkWell(
      onTap: () => onSelected(!isSelected),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              job['icon'],
              color: isSelected ? Colors.white : color,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              job['value'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernWorkTile({
    required Map<String, dynamic> work,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    Color workColor = work['color'];
    bool isSelected = groupValue == work['value'];

    return Card(
      elevation: isSelected ? 4 : 1,
      shadowColor: workColor.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? workColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: RadioListTile<String>(
        value: work['value'],
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: workColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          work['value'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? workColor : Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(work['subtitle'], style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: (work['benefits'] as List<String>).map((benefit) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: workColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    benefit,
                    style: TextStyle(
                      fontSize: 10,
                      color: workColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        secondary: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected
                ? workColor.withOpacity(0.15)
                : workColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(work['icon'], color: workColor, size: 26),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    required LinearGradient gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF00897B), width: 2),
        foregroundColor: const Color(0xFF00897B),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorText(String text) {
    return Row(
      children: [
        const Icon(Icons.error_outline, color: Color(0xFFE53935), size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: Color(0xFFE53935), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildModernInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF00897B)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // ACTIONS
  // =========================================================================

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Tampilkan Dialog Sukses
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00695C), Color(0xFF00897B)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00695C).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pendaftaran Berhasil!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF00695C),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                _buildModernInfoRow(
                  Icons.person,
                  'Nama Lengkap',
                  _namaController.text,
                ),
                const SizedBox(height: 12),
                _buildModernInfoRow(
                  Icons.cake,
                  'Umur',
                  '${_umurController.text} tahun',
                ),
                const SizedBox(height: 12),
                _buildModernInfoRow(
                  Icons.people,
                  'Jenis Kelamin',
                  _selectedGender!,
                ),
                const SizedBox(height: 12),
                _buildModernInfoRow(Icons.work, 'Pekerjaan', _selectedJob!),
                const SizedBox(height: 12),
                _buildModernInfoRow(
                  Icons.business_center,
                  'Tipe Pekerjaan',
                  _selectedWorkType!,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00897B),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'TUTUP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Tampilkan SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                'Data berhasil disimpan!!',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF00897B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  void _resetForm() {
    setState(() {
      _namaController.clear();
      _umurController.clear();
      _selectedGender = null;
      _selectedJob = null;
      _selectedWorkType = null;
      _formKey.currentState!.reset();
    });
  }
}
