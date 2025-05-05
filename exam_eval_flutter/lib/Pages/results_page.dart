import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'student_results_page.dart';

class ExamData {
  final String title;
  final bool isComplete;
  
  ExamData({required this.title, required this.isComplete});
}

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  // Sample exam data
  final List<ExamData> exams = [
    ExamData(title: 'Science Exam - 10th', isComplete: true),
    ExamData(title: 'Mathematics Exam - 10th', isComplete: false),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: const Color(0xFF2D5A27),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Results',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D5A27),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Responsive layout for exam result cards
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 800) {
                            // Horizontal layout for wider screens
                            return Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              alignment: WrapAlignment.center,
                              children: exams.map((exam) {
                                return SizedBox(
                                  width: (constraints.maxWidth / 2) - 30,
                                  child: ExamResultCard(
                                    title: exam.title,
                                    isComplete: exam.isComplete,
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            // Vertical layout for smaller screens
                            return Column(
                              children: exams.map((exam) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: ExamResultCard(
                                    title: exam.title,
                                    isComplete: exam.isComplete,
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExamResultCard extends StatefulWidget {
  final String title;
  final bool isComplete;

  const ExamResultCard({
    super.key, 
    required this.title,
    required this.isComplete,
  });

  @override
  State<ExamResultCard> createState() => _ExamResultCardState();
}

class _ExamResultCardState extends State<ExamResultCard> with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovering 
            ? (Matrix4.identity()..scale(1.03))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: Card(
          elevation: _isHovering ? 12 : 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlue.shade300,
                  Colors.blue.shade600,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Book icon with animation
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (BuildContext context, Widget? child) {
                      return Transform.scale(
                        scale: widget.isComplete ? 1.0 : _pulseAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.book_outlined,
                            size: 64,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  
                  // Button based on completion status
                  GestureDetector(
                    onTap: () {
                      if (widget.isComplete) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentResultsPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Results are still being calculated'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: _isHovering ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ] : null,
                      ),
                      child: Center(
                        child: Text(
                          widget.isComplete ? 'CHECK RESULTS' : 'CALCULATING....',
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Responsive version that can be integrated with the responsive layout
class ResponsiveResultsPage extends StatelessWidget {
  const ResponsiveResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResultsPage();
  }
} 