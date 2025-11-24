
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';

class AllComplaintsView extends StatelessWidget {
  const AllComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF3F5F8),
      appBar: AppBar(
        title: Text("الشكاوي المقدمة"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Cairo",
        ),
        backgroundColor: AppColor.primaryColor,

        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.notiPage);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.notifications, color: Colors.white, size: 28),
          ),
        ),
      ),
      body: const AllComplaintsPage(),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: 40),
          child: FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.addComplaintView);
            },
            backgroundColor: AppColor.primaryColor,
            shape: const CircleBorder(), // لضمان شكل دائري مثالي
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}

class AllComplaintsPage extends StatefulWidget {
  const AllComplaintsPage({super.key});

  @override
  State<AllComplaintsPage> createState() => _AllComplaintsPageState();
}

class _AllComplaintsPageState extends State<AllComplaintsPage> {
  // بيانات اختبارية جاهزة داخل الملف (self-contained)
  final List<ComplaintModel> complaints = [
    ComplaintModel(
      entity: 'وزارة الصحة',
      title: 'ازدحام شديد في مركز الرعاية',
      description:
          'يوجد ازدحام شديد في مركز الرعاية الأولية بسبب نقص الكوادر. يحتاج لتنظيم الفترات.',
      location: 'حي النخيل - شارع 12',
      reference: 'SHQ-2025-0001',
      status: 'قيد العمل',
      images: ['assets/img1.jpg', 'assets/img2.jpg', 'assets/img3.jpg'],
      files: ['تقرير_مبدئي.pdf', 'تقرير_مبدئي.pdf'],
      notes: 'تمت زيارة ميدانية مبدئية من قبل فريق المتابعة.',
      extraRequest:
          'الرجاء تزويدنا بعدد الأطباء في المركز وجدول دوامهم خلال الأسبوع الماضي.',
      extraReplies: ['تم استلام الطلب، الرجاء انتظار الرد.'],
      extraAttachments: [],
    ),
    ComplaintModel(
      entity: 'هيئة الاتصالات',
      title: 'ضعف تغطية الإنترنت',
      description: 'انقطاع متكرر في خدمة الانترنت في الحي على مدار اليوم.',
      location: 'منطقة الزهراء',
      reference: 'SHQ-2025-0002',
      status: 'تم الرفع',
      images: [],
      files: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return ComplaintCard(
          complaint: complaints[index],
          onUpdated: () {
            setState(() {}); // لإظهار أي تغييرات محلية (إضافة ردود/مرفقات)
          },
        );
      },
    );
  }
}

// ----------------------- Model -----------------------
class ComplaintModel {
  String entity;
  String title;
  String description;
  String location;
  String reference;
  String status;

  // ملاحظات (عرض فقط)
  String? notes;

  // طلب معلومات إضافية (قابل للرد وإضافة مرفقات)
  String? extraRequest;
  List<String> extraReplies;
  List<String> extraAttachments;

  // المرفقات الأساسية
  List<String> images; // مسارات صور assets أو urls
  List<String> files; // أسماء ملفات pdf/doc

  ComplaintModel({
    required this.entity,
    required this.title,
    required this.description,
    required this.location,
    required this.reference,
    required this.status,
    this.notes,
    this.extraRequest,
    List<String>? extraReplies,
    List<String>? extraAttachments,
    List<String>? images,
    List<String>? files,
  }) : extraReplies = extraReplies ?? [],
       extraAttachments = extraAttachments ?? [],
       images = images ?? [],
       files = files ?? [];
}

// ----------------------- ComplaintCard Widget -----------------------
class ComplaintCard extends StatefulWidget {
  final ComplaintModel complaint;
  final VoidCallback? onUpdated;

  const ComplaintCard({super.key, required this.complaint, this.onUpdated});

  @override
  State<ComplaintCard> createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    // البطاقة الرئيسية: رأس (جهة + عنوان) ثم محتوى قابل للتوسيع، ثم Divider وثابت الأسفل
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Header: اسم الجهة + نوع الشكوى (العنوان)
              _buildHeader(),

              const SizedBox(height: 8),

              // Expandable details (تظهر بعد الضغط)
              if (_expanded) _buildDetailsSection(),

              // دائمًا يظهر الفاصل والصف السفلي
              const SizedBox(height: 12),
              const Divider(height: 0.8, thickness: 0.7),
              const SizedBox(height: 8),

              // bottom row: الرقم المرجعي و حالة الشكوى ثابتان
              _buildBottomRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return InkWell(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.complaint.entity,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.complaint.title,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // سهم التوسيع
          Icon(
            _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey.shade700,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الوصف
        const SizedBox(height: 8),
        const Text('الوصف:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(widget.complaint.description),

        const SizedBox(height: 12),

        // الموقع
        const Text(
          'موقع الشكوى:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.location_on, size: 18, color: Colors.redAccent),
            const SizedBox(width: 6),
            Expanded(child: Text(widget.complaint.location)),
          ],
        ),

        const SizedBox(height: 12),

        // المرفقات - الصور
        if (widget.complaint.images.isNotEmpty) ...[
          const Text(
            'المرفقات (الصور):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildImagesGrid(widget.complaint.images),
          const SizedBox(height: 10),
        ],

        // المرفقات - ملفات
        if (widget.complaint.files.isNotEmpty) ...[
          const Text(
            'المرفقات (ملفات):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildFilesRow(widget.complaint.files),
          const SizedBox(height: 10),
        ],

        // ملاحظات الجهة (زر لعرض dialog)
        if (widget.complaint.notes != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _showNotesDialog(widget.complaint.notes!),
              icon: const Icon(
                Icons.sticky_note_2,
                color: AppColor.primaryColor,
              ),
              label: const Text(
                'عرض ملاحظات الجهة',
                style: TextStyle(color: AppColor.primaryColor),
              ),
            ),
          ),
        ],

        // طلب معلومات إضافية
        if (widget.complaint.extraRequest != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _showExtraRequestDialog(context),
              icon: const Icon(
                Icons.info_outline,
                color: AppColor.primaryColor,
              ),
              label: const Text(
                'طلب معلومات إضافية',
                style: TextStyle(color: AppColor.primaryColor),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildImagesGrid(List<String> images) {
    // grid من مربعات صغيرة بجانب بعضها
    return SizedBox(
      height: 100,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // افقي: صف واحد من العناصر
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: images.length,
        itemBuilder: (context, i) {
          final img = images[i];
          return GestureDetector(
            onTap: () => _openImageViewer(i, images),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Center(
                // محاكاة تحميل صورة من assets
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // لو الصورة مفقودة، نظهر placeholder مع اسم الملف
                    return Container(
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: Text(
                        img.split('/').last,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilesRow(List<String> files) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: files.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final f = files[i];
          return GestureDetector(
            onTap: () => _openFileDialog(f),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.primaryColor, width: 0.3),
              ),
              child: Row(
                children: [
                  const Icon(Icons.picture_as_pdf, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(f),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      children: [
        // الرقم المرجعي على اليمين (بسبب RTL)
        Expanded(
          child: Text(
            'الرقم المرجعي: ${widget.complaint.reference}',
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ),

        // حالة الشكوى كـ capsule
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _statusColor(widget.complaint.status).withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.complaint.status,
            style: TextStyle(
              color: _statusColor(widget.complaint.status),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'تم الإنجاز':
        return Colors.green;
      case 'قيد العمل':
        return Colors.orange;
      case 'تم الرفع':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  // ---------------- Dialogs & Utilities ----------------

  // فتح عارض صور مع أزرار تنقل
  void _openImageViewer(int startIndex, List<String> images) {
    final controller = PageController(initialPage: startIndex);
    int current = startIndex;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 24,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: Column(
                  children: [
                    // العنوان مع زر الإغلاق
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CloseButton(),
                          Text(
                            "المرفقات",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 40),
                        ],
                      ),
                    ),

                    // الصور
                    Expanded(
                      child: PageView.builder(
                        controller: controller,
                        itemCount: images.length,
                        onPageChanged: (i) => setState(() => current = i),
                        itemBuilder: (context, index) {
                          return InteractiveViewer(
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // النقاط
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: current == i ? 12 : 8,
                          height: current == i ? 12 : 8,
                          decoration: BoxDecoration(
                            color:
                                current == i
                                    ? AppColor.primaryColor
                                    : Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // فتح dialog للملفات
  void _openFileDialog(String filename) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'عرض الملف',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(filename),
                  subtitle: const Text('اضغط لتحميل الملف (محاكاة)'),
                  onTap: () {
                    // هنا يمكنك ربط تنزيل حقيقي
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم تحميل $filename (محاكاة)')),
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog عرض الملاحظات (View only) - يوجد أيقون إغلاق فقط
  void _showNotesDialog(String notes) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            height: MediaQuery.of(context).size.height * 0.55, // 👈 أطول
            child: Column(
              children: [
                Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close,color: AppColor.primaryColor,),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Text(
                            'ملاحظات الجهة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                const SizedBox(height: 4),

                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          notes,
                          style: const TextStyle(fontSize: 16, height: 1.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog لطلب معلومات إضافية: يعرض الطلب + حقل reply مع سهم الإرسال + أيقونة لإضافة مرفقات
void _showExtraRequestDialog(BuildContext context) {
  final TextEditingController replyController = TextEditingController();

  // قائمة الردود
  final List<Map<String, dynamic>> replies = [
    {"text": "هذا هو الطلب الأساسي من الجهة.", "isRequest": true},
    {"text": "مرحبا، نحتاج مزيداً من الإيضاح.", "isRequest": false},
  ];

  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor:Colors.grey.shade100 ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
              height: MediaQuery.of(context).size.height * 0.70, // 70%
              child: Column(
                children: [
                  // ------------------ HEADER ------------------ //
                 
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close,color: AppColor.primaryColor,),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Expanded(
                            child: Text(
                              'طلب معلومات إضافية',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                                            ),
                      ),
                  // ),

                  // const Divider(height: 1),

                  // ------------------ BODY (Scrollable) ------------------ //
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: replies.length,
                      itemBuilder: (context, index) {
                        final item = replies[index];
                        final isRequest = item["isRequest"];

                        return Align(
                          // alignment:
                          //     isRequest ? Alignment.centerLeft : Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            constraints: const BoxConstraints(maxWidth: 260),
                            decoration: BoxDecoration(
                              color: isRequest
                                  ? Colors.white
                                  : Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item["text"],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ------------------ INPUT BAR (Fixed Bottom) ------------------ //
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        // زر المرفقات
                        IconButton(
                          onPressed: () {
                          },
                          icon: const Icon(Icons.attach_file),
                        ),

                        // حقل الإدخال
                        Expanded(
                          child: TextField(
                            controller: replyController,
                            decoration: InputDecoration(
                              hintText: "اكتب ردك...",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // زر إرسال
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColor.primaryColor,
                          child: IconButton(
                            onPressed: () {
                              if (replyController.text.trim().isEmpty) return;
                          
                              setState(() {
                                replies.add({
                                  "text": replyController.text.trim(),
                                  "isRequest": false,
                                });
                              });
                          
                              replyController.clear();
                            },
                            icon: const Icon(Icons.send, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}



}
