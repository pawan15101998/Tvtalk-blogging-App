import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/model/post_model.dart';
import 'package:tvtalk/routers.dart';
import 'package:tvtalk/view/alllquiz_tab_page.dart';
import 'package:tvtalk/view/edit_profile_page.dart';
import 'package:tvtalk/view/feature_atricle_viewall_page.dart';
import 'package:tvtalk/view/feeds_detail_page.dart';
import 'package:tvtalk/view/fun_&_games.dart';
import 'package:tvtalk/view/home_page.dart';
import 'package:tvtalk/view/local_signin_page.dart';
import 'package:tvtalk/view/my_interest.dart';
import 'package:tvtalk/view/my_saved_articles.dart';
import 'package:tvtalk/view/poles_page.dart';
import 'package:tvtalk/view/privacy_policy.dart';
import 'package:tvtalk/view/profile_page.dart';
import 'package:tvtalk/view/quiz_already_taken_page.dart';
import 'package:tvtalk/view/quizes_page.dart';
import 'package:tvtalk/view/select_your_intrest.dart';
import 'package:tvtalk/view/signIn_screen.dart';
import 'package:tvtalk/view/register_page.dart';
import 'package:tvtalk/view/splash_screen.dart';
import 'package:tvtalk/view/term_&_condition.dart';
import 'package:tvtalk/view/trending_article_viewall_page.dart';

class CustomRouter{
  GoRouter goRouter = GoRouter(
    initialLocation: splashscreen,
    routes: <GoRoute>[
      GoRoute(
        name: 'SPLASHSCREEN',
        path: splashscreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
      name: 'SIGNINPAGE',
        path: signinpage,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: 'REGISTER',
        path: register,
        builder: (context, state) => const RegisterPage(),
      ), 
      GoRoute(
      name: 'HOMEPAGE',
        path: homepage,
        builder: (context, state) => const HomePage(),
      ),  
      GoRoute(
      name: 'MYSAVEDARTICLES',
        path: mysavedarticles,
        builder: (context, state) => const MySavedArticles(),
      ), 
      GoRoute(
      name: 'TERMANDCONDITION',
        path: termandcondition,
        builder: (context, state) => const TermAndCondition(),
      ),
      GoRoute(
      name: 'PRIVACYPOLICY',
        path: privacypolicy,
        builder: (context, state) => const PrivacyPolicy(),
      ),
      GoRoute(
      name: 'QUIZES',
        path: quizes,
        builder: (context, state) => const QuizesPage(),
      ),
      GoRoute(
      name: 'ALLQUIZPAGE',
        path: allquizpage,
        builder: (context, state) => const AllQuizPage(),
      ),
      GoRoute(
      name: 'QUIZALREADYTAKEN',
        path: quizalreadytaken,
        builder: (context, state) => const QuizAlreadytakenPage(),
      ),
      GoRoute(
      name: 'PROFILEPAGE',
        path: profilepage,
        builder: (context, state) => const Profilepage(),
      ),
      GoRoute(
      name: 'MYINTEREST',
        path: myinterest,
        builder: (context, state) => const MyInterest(),
      ),
      GoRoute(
      name: 'LOCALSIGNINPAGE',
        path: localsigninpage,
        builder: (context, state) => const LocalSignPage(),
      ),
      GoRoute(
      name: 'SELECTYOURINTREST',
        path: selectyourintrest,
        builder: (context, state) => const SelectYourIntrest(),
      ),
      GoRoute(
      name: 'ARTICLEDETAILPAGE',
        path: articledetailpage,
        builder: (context, state) =>  ArticleDetailPage(postData: state.extra, feedindex: state.queryParams, ),
      ),
       GoRoute(
      name: 'FUNANDGAMES',
        path: funandgamespage,
        builder: (context, state) => const FunAndGames(),
      ),
       GoRoute(
      name: 'POLES',
        path: poles,
        builder: (context, state) => const Poles(),
      ),
       GoRoute(
      name: 'EDITPROFILE',
        path: editprofile,
        builder: (context, state) => const Editprofilepage(),
      ),
      GoRoute(
      name: 'FEATUREARTICLEVIEWALL',
        path: featurearticleviewall,
        builder: (context, state) => const FeatureArticleViewAll(),
      ),
       GoRoute(
        name: 'TRENDINGARTICLEVIEWALL',
        path: trendingarticleviewall,
        builder: (context, state) => const TrendingArticleViewAll(),
      ),
    ]
    );
}