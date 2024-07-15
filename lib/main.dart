import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  bool _isCorrectAnswer = false;
  int _selectedAnswerIndex = -1;
  final List<Question> _questions = [
    Question('What is the capital of France?', {
      'Paris': true,
      'London': false,
      'Berlin': false,
      'Madrid': false,
    }),
    Question('Who wrote "Hamlet"?', {
      'Shakespeare': true,
      'Dickens': false,
      'Hemingway': false,
      'Orwell': false,
    }),
    Question('What is the largest planet in our Solar System?', {
      'Jupiter': true,
      'Earth': false,
      'Mars': false,
      'Saturn': false,
    }),
    Question('Who is the Prime Minister of India?', {
      'Narendra Modi': true,
      'Rahul Gandhi': false,
      'Amit Shah': false,
      'Arvind Kejriwal': false,
    }),
    Question('Who won the T20 World Cup 2024?', {
      'India': true,
      'Australia': false,
      'England': false,
      'Pakistan': false,
    }),
    Question('Who was the first President of the United States?', {
      
      'Thomas Jefferson': false,
      'Abraham Lincoln': false,
      'John Adams': false,
      'George Washington': true,
    }),
    Question('Who discovered America?', {
      
      'Vasco da Gama': false,
      'Christopher Columbus': true,
      'Amerigo Vespucci': false,
      'Ferdinand Magellan': false,
    }),
    Question('When did India gain independence?', {
      
      '1950': false,
      '1965': false,
      '1947': true,
      '1971': false,
    }),
    Question('Who was the first Emperor of India?', {
      'Chandragupta Maurya': true,
      'Ashoka': false,
      'Akbar': false,
      'Shivaji': false,
    }),
    Question('What is the smallest country in the world?', {
      
      'Liechtenstein': false,
      'Monaco': false,
      'Vatican City': true,
      'San Marino': false,
      
    }),
    
  ];

  void _answerQuestion(int index) {
    if (!_answered) {
      setState(() {
        _answered = true;
        _selectedAnswerIndex = index;
        _isCorrectAnswer = _questions[_currentQuestionIndex]
            .answers
            .values
            .elementAt(index);
        if (_isCorrectAnswer) {
          _score++;
        }
      });

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _currentQuestionIndex++;
          _answered = false;
          _selectedAnswerIndex = -1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: _currentQuestionIndex < _questions.length
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Rubesh Raman Quiz App 12115752',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Quiz(
                      question: _questions[_currentQuestionIndex],
                      answerQuestion: _answerQuestion,
                      answered: _answered,
                      selectedAnswerIndex: _selectedAnswerIndex,
                      isCorrectAnswer: _isCorrectAnswer,
                    ),
                  ),
                ],
              ),
            )
          : Result(
              score: _score,
              totalQuestions: _questions.length,
              resetQuiz: _resetQuiz,
            ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _answered = false;
      _selectedAnswerIndex = -1;
      _isCorrectAnswer = false;
    });
  }
}

class Quiz extends StatelessWidget {
  final Question question;
  final Function(int) answerQuestion;
  final bool answered;
  final int selectedAnswerIndex;
  final bool isCorrectAnswer;

  Quiz({
    required this.question,
    required this.answerQuestion,
    required this.answered,
    required this.selectedAnswerIndex,
    required this.isCorrectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          question.text,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ...question.answers.keys.map((answer) {
          int index = question.answers.keys.toList().indexOf(answer);
          return GestureDetector(
            onTap: () => answerQuestion(index),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: answered
                    ? (selectedAnswerIndex == index
                        ? (isCorrectAnswer
                            ? Colors.green
                            : Colors.red)
                        : Colors.white)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: answered
                      ? (selectedAnswerIndex == index
                          ? (isCorrectAnswer
                              ? Colors.green
                              : Colors.red)
                          : Colors.black)
                      : Colors.black,
                ),
              ),
              child: Text(
                answer,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class Question {
  final String text;
  final Map<String, bool> answers;

  Question(this.text, this.answers);
}

class Result extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Function resetQuiz;

  Result({
    required this.score,
    required this.totalQuestions,
    required this.resetQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Your Score: $score / $totalQuestions',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => resetQuiz(),
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
