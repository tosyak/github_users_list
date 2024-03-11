// This class defines a base class for all custom exceptions used in the application.
// It implements the Exception class, providing a common structure for error handling.
class AppExceptions implements Exception {
  // Internal property to store the exception message.
  final String? _message;

  // Internal property to store a prefix for the exception message.
  final String? _prefix;

  // Constructor that allows providing an optional message and prefix.
  AppExceptions([this._message, this._prefix]);

  // Override the default toString method to format the exception message with prefix.
  @override
  String toString() {
    return " $_prefix $_message"; // Add a space before to improve readability.
  }
}

// This class extends AppExceptions and represents exceptions that occur during data fetching.
class FetchDataException extends AppExceptions {
  // Constructor that allows providing an optional custom message.
  // By default, the prefix is set to "Error During Communication".
  FetchDataException({String? message})
      : super(message, "Error During Communication");
}

class BadRequestException extends AppExceptions {

  BadRequestException({String? message}) : super(message, "Invalid Request");
}


class UnAuthorizedException extends AppExceptions {

  UnAuthorizedException({String? message})
      : super(message, "Unauthorized request");
}


class InvalidInputException extends AppExceptions {

  InvalidInputException({String? message}) : super(message, "Invalid Input");
}
