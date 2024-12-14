class ButtonState {
  final bool isCopy;
  final bool isEdit;
  final bool isEditing;
  final bool isSaveAfterEditing;
  final bool isButtonDisabled;

  ButtonState({
    required this.isCopy,
    required this.isEdit,
    required this.isEditing,
    required this.isSaveAfterEditing,
    required this.isButtonDisabled,
  });

  /// Factory method to initialize state based on the type
  factory ButtonState.fromType(String type) {
    switch (type) {
      case 'Copy':
        return ButtonState(
          isCopy: true,
          isEdit: false,
          isEditing: false,
          isSaveAfterEditing: false,
          isButtonDisabled: false,
        );
      case 'Edit':
        return ButtonState(
          isCopy: false,
          isEdit: true,
          isEditing: false,
          isSaveAfterEditing: false,
          isButtonDisabled: false,
        );
      case 'Editing':
        return ButtonState(
          isCopy: false,
          isEdit: false,
          isEditing: true,
          isSaveAfterEditing: false,
          isButtonDisabled: false,
        );
      case 'Save_After_Editing':
        return ButtonState(
          isCopy: false,
          isEdit: false,
          isEditing: false,
          isSaveAfterEditing: true,
          isButtonDisabled: true,
        );
      case 'Save':
        return ButtonState(
          isCopy: false,
          isEdit: false,
          isEditing: false,
          isSaveAfterEditing: false,
          isButtonDisabled: true,
        );
      default:
        return ButtonState(
          isCopy: false,
          isEdit: false,
          isEditing: false,
          isSaveAfterEditing: false,
          isButtonDisabled: false,
        );
    }
  }
}
