import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uni_links/uni_links.dart';
import '../presentation/providers/auth_providers.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  final VoidCallback onVerificationSuccess;

  const EmailVerificationScreen({
    super.key,
    required this.onVerificationSuccess,
  });

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  bool _isResending = false;
  bool _isChecking = false;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// Handle incoming deep links from email verification
  void _handleIncomingLinks() async {
    // Handle initial link (app opened from link)
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(Uri.parse(initialLink));
      }
    } catch (e) {
      debugPrint('Error getting initial link: $e');
    }

    // Handle incoming links while app is running
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    }, onError: (err) {
      debugPrint('Error receiving link: $err');
    });
  }

  /// Handle deep link from email verification
  Future<void> _handleDeepLink(Uri uri) async {
    // Check if this is our verification deep link
    if (uri.scheme == 'com.divineseva.app' && uri.host == 'email_verified') {
      setState(() {
        _isChecking = true;
      });

      final authRepository = ref.read(authRepositoryProvider);
      final result = await authRepository.checkEmailVerification();

      setState(() {
        _isChecking = false;
      });

      if (!mounted) return;

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                failure.when(
                  generic: (msg) => msg,
                  network: (msg) => msg,
                  database: (msg) => msg,
                  auth: (msg) => msg,
                  validation: (msg) => msg,
                  notFound: (msg) => msg ?? 'Not found',
                  permissionDenied: (msg) => msg,
                  cache: (msg) => msg,
                  sync: (msg) => msg,
                  unknown: (error, stackTrace) => 'An unexpected error occurred',
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        },
        (isVerified) {
          if (isVerified) {
            widget.onVerificationSuccess();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email not verified yet. Please check your email.'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
      );
    }
  }

  /// Resend verification email
  Future<void> _resendVerificationEmail() async {
    setState(() {
      _isResending = true;
    });

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.sendEmailVerification();

    setState(() {
      _isResending = false;
    });

    if (!mounted) return;

    result.fold(
      (failure) {
        final errorMessage = failure.when(
          generic: (msg) => msg,
          network: (msg) => msg,
          database: (msg) => msg,
          auth: (msg) => msg,
          validation: (msg) => msg,
          notFound: (msg) => msg ?? 'Not found',
          permissionDenied: (msg) => msg,
          cache: (msg) => msg,
          sync: (msg) => msg,
          unknown: (error, stackTrace) => 'An unexpected error occurred',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      },
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification email sent! Please check your inbox.'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  /// Manually check verification status
  Future<void> _checkVerificationStatus() async {
    setState(() {
      _isChecking = true;
    });

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.checkEmailVerification();

    setState(() {
      _isChecking = false;
    });

    if (!mounted) return;

    result.fold(
      (failure) {
        final errorMessage = failure.when(
          generic: (msg) => msg,
          network: (msg) => msg,
          database: (msg) => msg,
          auth: (msg) => msg,
          validation: (msg) => msg,
          notFound: (msg) => msg ?? 'Not found',
          permissionDenied: (msg) => msg,
          cache: (msg) => msg,
          sync: (msg) => msg,
          unknown: (error, stackTrace) => 'An unexpected error occurred',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      },
      (isVerified) {
        if (isVerified) {
          widget.onVerificationSuccess();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email not verified yet. Please check your email.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF8B0000)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B0000).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.email_outlined,
                    size: 50,
                    color: Color(0xFF8B0000),
                  ),
                ),
                const SizedBox(height: 32),

                // Title
                const Text(
                  'Verify Your Email',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B0000),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Instructions
                const Text(
                  'We\'ve sent a verification email to your email address. '
                  'Please check your inbox and click the verification link to verify your account.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Info Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Didn\'t receive the email?',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Check your spam/junk folder\n'
                        '• Make sure you entered the correct email\n'
                        '• Wait a few minutes for the email to arrive',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Check Verification Status Button
                ElevatedButton(
                  onPressed: _isChecking ? null : _checkVerificationStatus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isChecking
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'I\'ve Verified My Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 16),

                // Resend Email Button
                OutlinedButton(
                  onPressed: _isResending ? null : _resendVerificationEmail,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF8B0000),
                    side: const BorderSide(color: Color(0xFF8B0000)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isResending
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B0000)),
                          ),
                        )
                      : const Text(
                          'Resend Verification Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 24),

                // Cancel Button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
