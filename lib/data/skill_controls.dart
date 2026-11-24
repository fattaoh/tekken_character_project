class SkillControlGuide {
  final String notation;
  final String? prerequisite;

  const SkillControlGuide(this.notation, {this.prerequisite});
}

const Map<String, Map<String, SkillControlGuide>> skillControlGuides = {
  'Yoshimitsu': {
    'Flash': SkillControlGuide('d+1+4'),
    'Manji Dragonfly': SkillControlGuide('u+1+2'),
    'Flea': SkillControlGuide(
      'd+1+2',
      prerequisite: 'Hadapkan punggung karakter ke lawan terlebih dahulu.',
    ),
    'Sword Sweep': SkillControlGuide(
      'FC.df+1',
      prerequisite: 'Mulai dari posisi jongkok.',
    ),
  },
  'Steve Fox': {
    'Flicker': SkillControlGuide('b+3+4'),
    'Peekaboo': SkillControlGuide('f+3+4'),
    'Sonic Fang': SkillControlGuide(
      'WS.1+2',
      prerequisite: 'Tekan saat karakter bangkit dari posisi jongkok.',
    ),
  },
  'Reina': {
    'Sentai': SkillControlGuide('f+3'),
    'Unsoku': SkillControlGuide('d+3'),
    'Heaven’s Wrath': SkillControlGuide('d+1+2'),
    'Electric Wind God Fist': SkillControlGuide('f,n,d,df#2'),
  },
  'King': {
    'Giant Swing': SkillControlGuide('f,hcf+1'),
    'Jaguar Step': SkillControlGuide('3+4'),
    'Shining Wizard': SkillControlGuide('f,f,F+2+4'),
    'Muscle Buster': SkillControlGuide('qcb+1+2'),
  },
  'Kazuya Mishima': {
    'Wind God Fist': SkillControlGuide('f,n,d,df+2'),
    'Hell Lancer': SkillControlGuide('f,n,d,df+3'),
    'Demon God Fist': SkillControlGuide('WS.2'),
    'Devil Blaster': SkillControlGuide(
      '3+4',
      prerequisite: 'Aktifkan bentuk Devil terlebih dahulu.',
    ),
  },
  'Jin Kazama': {
    'Electric Wind Hook Fist': SkillControlGuide('CD.df#2'),
    'Demon Paw': SkillControlGuide('f+4'),
    'Zanshin': SkillControlGuide('b+3+4'),
  },
  'Hwoarang': {
    'Left Flamingo': SkillControlGuide('f+3'),
    'Right Flamingo': SkillControlGuide('f,n,4'),
    'Sky Rocket': SkillControlGuide('CD.4'),
    'Hunting Hawk': SkillControlGuide('uf+3,4,3'),
  },
  'Heihachi Mishima': {'Wind God Fist': SkillControlGuide('f,n,d,df+2')},
  'Eddy Gordo': {
    'Handstand': SkillControlGuide('f+1+2'),
    'Negativa': SkillControlGuide('d+3+4'),
  },
  'Armor King': {
    'Dark Upper': SkillControlGuide('f,n,df#2'),
    'Shining Wizard': SkillControlGuide('f,f,F+2+4'),
    'Jaguar Step': SkillControlGuide('3+4'),
  },
};

List<String> buildControllerSteps(String notation) {
  var input = notation;
  final steps = <String>[];
  final stanceSeparator = input.indexOf('.');

  if (stanceSeparator >= 0) {
    final stance = input.substring(0, stanceSeparator);
    input = input.substring(stanceSeparator + 1);
    final prerequisite = switch (stance) {
      'BT' => 'Pastikan karakter membelakangi lawan.',
      'FC' => 'Mulai dari posisi jongkok.',
      'WS' => 'Tekan saat karakter bangkit dari posisi jongkok.',
      'DVK' => 'Aktifkan bentuk Devil terlebih dahulu.',
      'MED' => 'Masuk ke Meditation stance terlebih dahulu.',
      'KIN' => 'Masuk ke Kincho stance terlebih dahulu.',
      'FLE' => 'Masuk ke Flea stance terlebih dahulu.',
      'JGS' => 'Masuk ke Jaguar Step terlebih dahulu.',
      'CD' => 'Lakukan crouch dash: depan, netral, bawah, bawah-depan.',
      _ => null,
    };
    if (prerequisite != null) {
      steps.add(prerequisite);
    }
  }

  input = input.replaceAllMapped(
    RegExp(r'hcf(?:\+(.+))?'),
    (match) =>
        'b,db,d,df,f${match.group(1) == null ? '' : '+${match.group(1)}'}',
  );
  input = input.replaceAllMapped(
    RegExp(r'qcb(?:\+(.+))?'),
    (match) => 'd,db,b${match.group(1) == null ? '' : '+${match.group(1)}'}',
  );

  for (final rawStep in input.split(',')) {
    final step = rawStep.trim();
    if (step.isEmpty) continue;

    if (step == 'n') {
      steps.add('Lepaskan D-pad sebentar ke posisi netral.');
      continue;
    }

    final isRun = step.startsWith('F');
    final normalizedStep = step.toLowerCase();
    final directionMatch = RegExp(r'^(uf|df|ub|db|f|b|u|d)(#)?(?:\+?(.+))?$')
        .firstMatch(normalizedStep);

    if (directionMatch == null) {
      steps.add('Tekan tombol ${_controllerButtons(step)}.');
      continue;
    }

    final direction = _directionName(directionMatch.group(1)!);
    final buttons = directionMatch.group(3);
    final justFrame = directionMatch.group(2) != null;
    final action = buttons == null
        ? 'Tekan D-pad ke $direction'
        : 'Tekan D-pad ke $direction sambil menekan '
              '${_controllerButtons(buttons)} bersamaan';
    steps.add(
      '$action${isRun ? ' saat berlari' : ''}'
      '${justFrame ? ' dengan timing tepat (Just Frame)' : ''}.',
    );
  }

  return steps;
}

String _directionName(String direction) {
  return switch (direction) {
    'f' => 'depan (arah lawan)',
    'b' => 'belakang (menjauhi lawan)',
    'u' => 'atas',
    'd' => 'bawah',
    'df' => 'bawah-depan (arah lawan)',
    'db' => 'bawah-belakang (menjauhi lawan)',
    'uf' => 'atas-depan (arah lawan)',
    'ub' => 'atas-belakang (menjauhi lawan)',
    _ => direction,
  };
}

String _controllerButtons(String input) {
  const buttons = {
    '1': '□ (PlayStation) / X (Xbox)',
    '2': '△ (PlayStation) / Y (Xbox)',
    '3': '× (PlayStation) / A (Xbox)',
    '4': '○ (PlayStation) / B (Xbox)',
  };
  return input
      .split('+')
      .map((button) => buttons[button] ?? button)
      .join(' + ');
}
