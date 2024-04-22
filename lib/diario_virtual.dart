import 'entrada_diario.dart';

class DiarioVirtual {
  List<EntradaDiario> entradas = [];

  void agregarEntrada(EntradaDiario entrada) {
    entradas.add(entrada);
  }

  void eliminarEntrada(int indice) {
    entradas.removeAt(indice);
  }

  void editarEntrada(int indice, EntradaDiario nuevaEntrada) {
    entradas[indice] = nuevaEntrada;
  }
}
