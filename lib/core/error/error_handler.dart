class ErrorHandler {
  static String handlerError(int statusCode){
    switch(statusCode){
      case 400:
        return "Bad Request";
      case 401:
        return "Unauthorized";
      case 403:
        return "Forbidden";
      case 404:
        return "Not Found";
      case 500:
        return "Internal Server Error";
      default:
        return "Unknown Error";
    }
  }
}