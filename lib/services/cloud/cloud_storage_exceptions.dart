class CloudStorageException implements Exception {
  const CloudStorageException();
}

//C IN CRUD
class CouldNotCreateNoteException extends CloudStorageException {}

//R IN CRUD
class CouldNotGetAllNotesException extends CloudStorageException {}

// U IN CRUD
class CouldNotUpdateNoteException extends CloudStorageException {}

//D IN CRUD
class CouldNotDeleteNoteException extends CloudStorageException {}
