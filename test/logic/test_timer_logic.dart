import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';

void main() {
  test('Timer set', () {
    final ProviderContainer container = createContainer();

    // test if timer initial value is 0
    container.read(timerLogicProvider.notifier).resetTimer();
    expect(
      container.read(timerLogicProvider).value,
      Clock(
        mainTimer: Duration.zero,
        assistTimer: Duration.zero,
        bonusTimer: Duration.zero,
      ),
    );

    // set example timer and check
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.main,
          const Duration(seconds: 10),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.assist,
          const Duration(seconds: 8),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.bonus,
          const Duration(seconds: 6),
        );

    expect(
      container.read(timerLogicProvider).value,
      Clock(
        mainTimer: const Duration(seconds: 10),
        assistTimer: const Duration(seconds: 8),
        bonusTimer: const Duration(seconds: 6),
      ),
    );

    addTearDown(container.dispose);
  });

  test('Timer start', () {
    final ProviderContainer container = createContainer();
    container.read(timerBeatProvider.notifier).timerBeatLogic();

    // set timer
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.main,
          const Duration(seconds: 10),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.assist,
          const Duration(seconds: 8),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.bonus,
          const Duration(seconds: 6),
        );

    // make sure we're setting the right timer
    expect(
      container.read(timerLogicProvider).value,
      Clock(
        mainTimer: const Duration(seconds: 10),
        assistTimer: const Duration(seconds: 8),
        bonusTimer: const Duration(seconds: 6),
      ),
    );

    // start timer
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);

    // wait for 2 second and check the result
    Future.delayed(const Duration(seconds: 2), () {
      expect(
        container.read(timerLogicProvider).value,
        Clock(
          mainTimer: const Duration(seconds: 8),
          assistTimer: const Duration(seconds: 6),
          bonusTimer: const Duration(seconds: 4),
        ),
      );
    });

    addTearDown(container.dispose);
  });

  test('Timer pause', () {
    final ProviderContainer container = createContainer();
    container.read(timerBeatProvider.notifier).timerBeatLogic();

    // set timer
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.main,
          const Duration(seconds: 10),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.assist,
          const Duration(seconds: 8),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.bonus,
          const Duration(seconds: 6),
        );

    // make sure we're setting the right timer
    expect(
      container.read(timerLogicProvider).value,
      Clock(
        mainTimer: const Duration(seconds: 10),
        assistTimer: const Duration(seconds: 8),
        bonusTimer: const Duration(seconds: 6),
      ),
    );

    // start timer
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);

    // wait for 2 second and pause
    Future.delayed(const Duration(seconds: 2), () {
      container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.stopped);
    });

    // wait for another 2 second and check the result, timer should stay the same...
    Future.delayed(const Duration(seconds: 2), () {
      expect(
        container.read(timerLogicProvider).value,
        Clock(
          mainTimer: const Duration(seconds: 8),
          assistTimer: const Duration(seconds: 6),
          bonusTimer: const Duration(seconds: 4),
        ),
      );
    });

    addTearDown(container.dispose);
  });

  test('Timer reset', () {
    final ProviderContainer container = createContainer();
    container.read(timerBeatProvider.notifier).timerBeatLogic();

    // set timer
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.main,
          const Duration(seconds: 10),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.assist,
          const Duration(seconds: 8),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.bonus,
          const Duration(seconds: 6),
        );

    // make sure we're setting the right timer
    expect(
      container.read(timerLogicProvider).value,
      Clock(
        mainTimer: const Duration(seconds: 10),
        assistTimer: const Duration(seconds: 8),
        bonusTimer: const Duration(seconds: 6),
      ),
    );

    // start timer
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);

    // reset timer after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      container.read(timerLogicProvider.notifier).resetTimer();

      expect(
        container.read(timerLogicProvider).value,
        Clock(
          mainTimer: Duration.zero,
          assistTimer: Duration.zero,
          bonusTimer: Duration.zero,
        ),
      );
      expect(container.read(timerBeatProvider).value, TimerStatus.stopped);
    });

    addTearDown(container.dispose);
  });

  test('Timer spam start/pause', () {
    /* reason behind this.. in previous version of this app, there's a bug where the user presses start/pause
    multiple times in a rapid succession, the timer will be faster each time user spam the start/pause button...
    this test make sure it doesn't happen again
    */

    final ProviderContainer container = createContainer();
    container.read(timerBeatProvider.notifier).timerBeatLogic();

    // set timer
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.main,
          const Duration(seconds: 10),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.assist,
          const Duration(seconds: 8),
        );
    container.read(timerLogicProvider.notifier).setTimer(
          TimerType.bonus,
          const Duration(seconds: 6),
        );

    // spam the timer with multiple start/pause
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.stopped);
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.stopped);
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.stopped);
    container.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);

    // wait for 2 second and check the result
    Future.delayed(const Duration(seconds: 2), () {
      expect(
        container.read(timerLogicProvider).value,
        Clock(
          mainTimer: const Duration(seconds: 8),
          assistTimer: const Duration(seconds: 6),
          bonusTimer: const Duration(seconds: 4),
        ),
      );
    });

    addTearDown(container.dispose);
  });
}

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const <Override>[],
  List<ProviderObserver>? observers,
}) {
  final ProviderContainer container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);
  return container;
}
