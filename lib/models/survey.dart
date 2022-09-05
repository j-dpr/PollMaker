// To parse this JSON data, do
//
//     final survey = surveyFromMap(jsonString);

import 'dart:convert';

class Survey {
    Survey({
        required this.encuestas,
    });

    Encuestas encuestas;

    factory Survey.fromJson(String str) => Survey.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Survey.fromMap(Map<String, dynamic> json) => Survey(
        encuestas: Encuestas.fromMap(json["encuestas"]),
    );

    Map<String, dynamic> toMap() => {
        "encuestas": encuestas.toMap(),
    };
}

class Encuestas {
    Encuestas({
        required this.survey,
    });

    SurveyClass survey;

    factory Encuestas.fromJson(String str) => Encuestas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Encuestas.fromMap(Map<String, dynamic> json) => Encuestas(
        survey: SurveyClass.fromMap(json["survey"]),
    );

    Map<String, dynamic> toMap() => {
        "survey": survey.toMap(),
    };
}

class SurveyClass {
    SurveyClass({
        required this.desc,
        required this.name,
        this.id,
        required this.answers,
        required this.optionals,
        required this.questions,
        this.url,
    });

    String desc;
    String name;
    String? id;
    Answers answers;
    Optionals optionals;
    Questions questions;
    String? url;

    factory SurveyClass.fromJson(String str) => SurveyClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SurveyClass.fromMap(Map<String, dynamic> json) => SurveyClass(
        desc: json["desc"],
        name: json["name"],
        id: json["id"],
        answers: Answers.fromMap(json["answers"]),
        optionals: Optionals.fromMap(json["optionals"]),
        questions: Questions.fromMap(json["questions"]),
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "desc": desc,
        "name": name,
        "id": id,
        "answers": answers.toMap(),
        "optionals": optionals.toMap(),
        "questions": questions.toMap(),
        "url": url,
    };

    SurveyClass copy() => SurveyClass(
        desc: this.desc,
        name: this.name,
        id: this.id,
        answers: this.answers,
        optionals: this.optionals,
        questions: this.questions,
        url: this.url,
    );
}

class Answers {
    Answers({
        required this.answ,
    });

    Answ answ;

    factory Answers.fromJson(String str) => Answers.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Answers.fromMap(Map<String, dynamic> json) => Answers(
        answ: Answ.fromMap(json["answ"]),
    );

    Map<String, dynamic> toMap() => {
        "answ": answ.toMap(),
    };
}

class Answ {
    Answ({
        this.answer,
        required this.questionId,
        required this.id,
    });

    String? answer;
    String questionId;
    String id;

    factory Answ.fromJson(String str) => Answ.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Answ.fromMap(Map<String, dynamic> json) => Answ(
        answer: json["answer"],
        questionId: json["questionId"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "answer": answer,
        "questionId": questionId,
        "id": id,
    };
}

class Optionals {
    Optionals({
        required this.opq,
    });

    Opq opq;

    factory Optionals.fromJson(String str) => Optionals.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Optionals.fromMap(Map<String, dynamic> json) => Optionals(
        opq: Opq.fromMap(json["opq"]),
    );

    Map<String, dynamic> toMap() => {
        "opq": opq.toMap(),
    };
}

class Opq {
    Opq({
        required this.optional,
        required this.questionId,
        required this.id,
    });

    bool optional;
    String questionId;
    String id;

    factory Opq.fromJson(String str) => Opq.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Opq.fromMap(Map<String, dynamic> json) => Opq(
        optional: json["optional"],
        questionId: json["questionId"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "optional": optional,
        "questionId": questionId,
        "id": id,
    };
}

class Questions {
    Questions({
        required this.qst,
    });

    Qst qst;

    factory Questions.fromJson(String str) => Questions.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Questions.fromMap(Map<String, dynamic> json) => Questions(
        qst: Qst.fromMap(json["qst"]),
    );

    Map<String, dynamic> toMap() => {
        "qst": qst.toMap(),
    };
}

class Qst {
    Qst({
        required this.questionId,
        required this.title,
    });

    String questionId;
    String title;

    factory Qst.fromJson(String str) => Qst.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Qst.fromMap(Map<String, dynamic> json) => Qst(
        questionId: json["questionId"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "questionId": questionId,
        "title": title,
    };
}
