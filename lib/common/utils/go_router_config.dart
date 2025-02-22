import 'package:flutter/material.dart';
import 'package:flutter_memorize/features/card/data/models/card.dart' as m;
import 'package:flutter_memorize/features/card/data/models/deck.dart';
import 'package:flutter_memorize/features/card/presentation/pages/card_append_screen.dart';
import 'package:flutter_memorize/features/card/presentation/pages/card_update_screen.dart';
import 'package:flutter_memorize/features/card/presentation/pages/deck_append_screen.dart';
import 'package:flutter_memorize/features/card/presentation/pages/deck_detail_screen.dart';
import 'package:flutter_memorize/features/card/presentation/pages/deck_list_screen.dart';
import 'package:flutter_memorize/features/card/presentation/pages/deck_update_screen.dart';
import 'package:flutter_memorize/features/home/presentation/pages/home_screen.dart';
import 'package:flutter_memorize/features/memorize/presentation/pages/memorize_list_screen.dart';
import 'package:flutter_memorize/features/setting/presentation/pages/setting_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Memorize'),
          ),
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: '학습시작',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_card),
                label: '카드관리',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '설정',
              ),
            ],
            currentIndex: navigationShell.currentIndex,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.grey,
            onTap: (int index) {
              navigationShell.goBranch(index, initialLocation: true);
            },
          ),
        );
      },
      branches: <StatefulShellBranch>[
        // Tab 1
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: '/',
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeScreen()),
          ],
        ),
        // Tab 2
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/memorized',
              builder: (BuildContext context, GoRouterState state) =>
                  const MemorizeListScreen(),
            ),
          ],
        ),
        // Tab 3
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/decks',
              builder: (BuildContext context, GoRouterState state) =>
                  const DeckListScreen(),
              routes: [
                GoRoute(
                  path: '/add',
                  builder: (context, state) => DeckAppendScreen(),
                ),
                GoRoute(
                    path: '/:deckId',
                    builder: (context, state) => DeckDetailScreen(
                          deck: GoRouterState.of(context).extra! as Deck,
                        ),
                    routes: [
                      GoRoute(
                        path: '/update',
                        builder: (context, state) => DeckUpdateScreen(
                          deck: GoRouterState.of(context).extra! as Deck,
                        ),
                      ),
                      GoRoute(
                        path: '/cards/add',
                        builder: (context, state) => CardAppendScreen(
                          deck: GoRouterState.of(context).extra! as Deck,
                        ),
                      ),
                      GoRoute(
                        path: '/cards/:cardId',
                        builder: (context, state) => CardUpdateScreen(
                          card: GoRouterState.of(context).extra! as m.Card,
                        ),
                      ),
                    ]),
              ],
            ),
          ],
        ),
        // Tab 4
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/settings',
              builder: (BuildContext context, GoRouterState state) =>
                  const SettingScreen(),
            ),
          ],
        ),
      ],
    )
  ],
);
