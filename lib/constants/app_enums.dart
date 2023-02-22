enum AuthStatus {
  initial,
  authenticating,
  authenticated,
  unAuthenticated,
  authenticationFailed,
  unAuthorisedAccess,
}

enum UserType {
  user,
  unKnown,
}

enum PageStatus {
  initial,
  loading,
  loaded,
  loadingFailed,
  updating,
  updatingFailed,
  updated,
  validationError
}

