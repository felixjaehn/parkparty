enum LocationType {
  waiting,
  keineBerechtigung,
  keineStandortdienste,
  erneutKeineBerechtigung,
  erneutKeineStandortdienste,
  keinLiefergebiet,
  liefergebiet,
}

enum SimpleLocation {
  waiting,
  failed,
  done,
}

enum LocationStatus {
  liefergebiet,
  keinLiefergebiet,
  timeout,
  keinStandort,
}
