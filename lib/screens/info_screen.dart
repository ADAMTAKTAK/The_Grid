import 'package:flutter/material.dart';
import 'package:the_grid/themes/app_theme.dart'; 
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  Future<void> _launchGitHub(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    const Color activeColor = AppTheme.error;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SYSTEM ADMIN', 
          style: TextStyle(fontFamily: 'Blanka', color: activeColor)
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: activeColor),
      ),
      body: SafeArea(
        child: isLandscape 
          ? _LandscapeLayout(onGithubTap: _launchGitHub)
          : _PortraitLayout(onGithubTap: _launchGitHub),
      ),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  final Function(String) onGithubTap;
  const _PortraitLayout({required this.onGithubTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const _TeamPhoto(height: 450),
                const SizedBox(height: 30),
                const _TeamIdentity(),
                const SizedBox(height: 20),
                const _TeamDescription(),
                const SizedBox(height: 40),
                _AgentList(onGithubTap: onGithubTap),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        const _SystemFooter(),
      ],
    );
  }
}

class _LandscapeLayout extends StatelessWidget {
  final Function(String) onGithubTap;
  const _LandscapeLayout({required this.onGithubTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: _TeamPhoto(height: double.infinity), 
          ),
        ),
        
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      const _TeamIdentity(),
                      const SizedBox(height: 20),
                      const _TeamDescription(),
                      const SizedBox(height: 30),
                      _AgentList(onGithubTap: onGithubTap),
                    ],
                  ),
                ),
              ),
              const _SystemFooter(),
            ],
          ),
        ),
      ],
    );
  }
}

class _TeamPhoto extends StatelessWidget {
  final double height;
  const _TeamPhoto({required this.height});

  @override
  Widget build(BuildContext context) {
    const activeColor = AppTheme.error;
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: activeColor),
        image: const DecorationImage(
          image: AssetImage('assets/images/daft_devs.png'), 
          fit: BoxFit.cover,
          alignment: Alignment.topCenter, 
          opacity: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: activeColor.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: 2
          )
        ]
      ),
    );
  }
}

class _TeamIdentity extends StatelessWidget {
  const _TeamIdentity();

  @override
  Widget build(BuildContext context) {
    const activeColor = AppTheme.error;
    const dataColor = AppTheme.primary;
    
    return Column(
      children: [
        Text(
          'WE ARE ENCOM', 
          style: TextStyle(
            fontFamily: 'Blanka', 
            fontSize: 40, 
            color: dataColor,
            shadows: [Shadow(color: dataColor, blurRadius: 20)]
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'FLUTTER DEVELOPERS',
          style: TextStyle(
            fontFamily: 'Orbit', 
            fontSize: 14, 
            color: activeColor,
            letterSpacing: 4,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}

class _TeamDescription extends StatelessWidget {
  const _TeamDescription();

  @override
  Widget build(BuildContext context) {
    const dataColor = AppTheme.primary;
    
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12)
      ),
      child: Text(
        'We are architecting the digital frontier. Dedicated to building immersive and high-performance applications using Flutter technology. Access to our source code is restricted to authorized personnel only.',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: 'Orbit', 
          fontSize: 12, 
          color: dataColor,
          height: 1.5,
          shadows: [Shadow(color: dataColor, blurRadius: 2)]
        ),
      ),
    );
  }
}

class _AgentList extends StatelessWidget {
  final Function(String) onGithubTap;
  const _AgentList({required this.onGithubTap});

  @override
  Widget build(BuildContext context) {
    const activeColor = AppTheme.error;
    const dataColor = AppTheme.primary;

    return Column(
      children: [
        _AgentCard(
          name: 'PABLO GUEVARA',
          phone: '+58 424 826 8559', 
          githubUrl: 'https://github.com/Pabloguevara10',
          imagePath: 'assets/images/pablo.jpg', 
          activeColor: activeColor,
          dataColor: dataColor,
          onTap: () => onGithubTap('https://github.com/Pabloguevara10'),
        ),
        const SizedBox(height: 20),
        _AgentCard(
          name: 'ADAM TAKTAK',
          phone: '+58 414 626 3358', 
          githubUrl: 'https://github.com/ADAMTAKTAK',
          imagePath: 'assets/images/adam.jpg',
          activeColor: activeColor,
          dataColor: dataColor,
          onTap: () => onGithubTap('https://github.com/ADAMTAKTAK'),
        ),
      ],
    );
  }
}

class _SystemFooter extends StatelessWidget {
  const _SystemFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      color: Colors.black,
      alignment: Alignment.center,
      child: const Text(
        'ACCESS GRANTED', 
        style: TextStyle(
          color: AppTheme.error, 
          fontFamily: 'Orbit', 
          fontSize: 10,
          letterSpacing: 2
        )
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  final String name;
  final String phone;
  final String githubUrl;
  final String imagePath; 
  final Color activeColor;
  final Color dataColor;
  final VoidCallback onTap;

  const _AgentCard({
    required this.name,
    required this.phone,
    required this.githubUrl,
    required this.imagePath, 
    required this.activeColor,
    required this.dataColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: activeColor.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: activeColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'AGENT PROFILE', 
                  style: TextStyle(
                    color: AppTheme.secondary,
                    fontFamily: 'Orbit', 
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                  )
                ),
                CircleAvatar(
                  radius: 30, 
                  backgroundColor: activeColor.withValues(alpha: 0.2),
                  backgroundImage: AssetImage(imagePath), 
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Blanka', 
                fontSize: 22, 
                color: dataColor, 
                shadows: [Shadow(color: dataColor.withValues(alpha: 0.5), blurRadius: 5)]
              ),
            ),
            const Divider(color: Colors.grey, height: 20, thickness: 0.5),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey[400], size: 16),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    phone,
                    style: TextStyle(fontFamily: 'Orbit', color: dataColor, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.link, color: Colors.grey[400], size: 16),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    githubUrl.replaceFirst('https://', ''),
                    style: TextStyle(fontFamily: 'Orbit', color: activeColor, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'TAP TO ACCESS GITHUB >>', 
                style: TextStyle(color: activeColor, fontFamily: 'Blanka', fontSize: 10)
              ),
            )
          ],
        ),
      ),
    );
  }
}