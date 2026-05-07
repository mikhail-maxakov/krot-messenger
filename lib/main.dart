import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'К.Р.О.Т.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: const MoleSplashScreen(),
    );
  }
}

class MoleSplashScreen extends StatefulWidget {
  const MoleSplashScreen({super.key});

  @override
  State<MoleSplashScreen> createState() => _MoleSplashScreenState();
}

class _MoleSplashScreenState extends State<MoleSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    
    _scale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _controller.forward();
    
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/mole.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[900],
                          child: const Center(
                            child: Text(
                              '🦡',
                              style: TextStyle(fontSize: 80, color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'К.Р.О.Т.',
                  style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 1,
                  color: Colors.white24,
                ),
                const SizedBox(height: 15),
                Text(
                  'Когда Разговор Особо Тайный',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.5,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'БЕЗОПАСНЫЙ МЕССЕНДЖЕР',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: Colors.grey[600],
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

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _serverIpController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _isLoginMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'К.Р.О.Т.',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.white24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Логотип
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white38, width: 1),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/mole.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: Text('🦡', style: TextStyle(fontSize: 40)),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Заголовок
            Text(
              _isLoginMode ? 'ВХОД В К.Р.О.Т.' : 'РЕГИСТРАЦИЯ',
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: 3,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // IP сервера
            TextField(
              controller: _serverIpController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'IP СЕРВЕРА',
                labelStyle: TextStyle(color: Colors.grey[500], fontSize: 11),
                hintText: '192.168.1.100',
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: Icon(Icons.dns, color: Colors.grey[500], size: 20),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Имя пользователя
            TextField(
              controller: _usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'ИМЯ ПОЛЬЗОВАТЕЛЯ',
                labelStyle: TextStyle(color: Colors.grey[500], fontSize: 11),
                prefixIcon: Icon(Icons.person_outline, color: Colors.grey[500], size: 20),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Телефон
            TextField(
              controller: _phoneController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'ТЕЛЕФОН',
                labelStyle: TextStyle(color: Colors.grey[500], fontSize: 11),
                hintText: '+7XXXXXXXXXX',
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: Icon(Icons.phone_android, color: Colors.grey[500], size: 20),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Пароль
            TextField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              obscureText: _obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'ПАРОЛЬ',
                labelStyle: TextStyle(color: Colors.grey[500], fontSize: 11),
                prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[500], size: 20),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[500],
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Кнопка входа/регистрации
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Введите пароль'),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _isLoginMode ? 'Вход в систему...' : 'Регистрация...',
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text(
                  _isLoginMode ? 'ВОЙТИ' : 'ЗАРЕГИСТРИРОВАТЬСЯ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Переключатель между входом и регистрацией
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isLoginMode ? 'Нет аккаунта?' : 'Уже есть аккаунт?',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLoginMode = !_isLoginMode;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    _isLoginMode ? 'СОЗДАТЬ' : 'ВОЙТИ',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // ПЕЧАТАЮЩАЯСЯ РАСШИФРОВКА ВНИЗУ
            const TypewriterText(),
          ],
        ),
      ),
    );
  }
}

// Виджет с эффектом печатающегося текста
class TypewriterText extends StatefulWidget {
  const TypewriterText({super.key});

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = '';
  int _currentIndex = 0;
  
  // Новая расшифровка К.Р.О.Т.
  final String _fullText = 'К — Кодированный | Р — Разговор | О — Онлайн | Т — Товарищей';
  
  @override
  void initState() {
    super.initState();
    _startTyping();
  }
  
  void _startTyping() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_currentIndex < _fullText.length) {
        setState(() {
          _displayedText += _fullText[_currentIndex];
          _currentIndex++;
        });
        _startTyping();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 1,
            color: Colors.white12,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  _displayedText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 1,
                    color: Colors.grey[500],
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              if (_currentIndex < _fullText.length)
                Container(
                  width: 2,
                  height: 12,
                  color: Colors.grey[500],
                  margin: const EdgeInsets.only(left: 2),
                ),
            ],
          ),
        ],
      ),
    );
  }
}