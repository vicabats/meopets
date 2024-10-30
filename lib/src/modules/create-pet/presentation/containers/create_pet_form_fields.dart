enum FormFieldValueType { text, date }

typedef FormFieldData = Map<String, dynamic>;

final List<FormFieldData> createPetformFields = [
  {
    'label': 'Nome',
    'key': 'name',
    'value': '',
    'type': FormFieldValueType.text,
  },
  {
    'label': 'Tipo',
    'key': 'type',
    'value': '',
    'type': FormFieldValueType.text,
  },
  {
    'label': 'Descrição',
    'key': 'description',
    'value': '',
    'type': FormFieldValueType.text,
  },
  {
    'label': 'Url da foto',
    'key': 'imageUrl',
    'value': '',
    'type': FormFieldValueType.text,
  },
  {
    'label': 'Data de nascimento',
    'key': 'birthDate',
    'value': DateTime.now(),
    'type': FormFieldValueType.date,
  },
];
