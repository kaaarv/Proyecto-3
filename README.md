# Proyecto-3. Procesador RISC Uniciclo

**Estudiantes:**
- Fernandez Aguilar Randy Steve  
- Matarrita Hernandez Nayeli  
- Quiros Avila Karina  
- Tencio Valverde Yonaikel Fabricio

Este proyecto consiste en la implementación de un procesador RISC uniciclo desarrollado en SystemVerilog. Un procesador uniciclo ejecuta cada instrucción completamente en un único ciclo de reloj, lo que implica que todas las etapas —búsqueda de instrucción, decodificación, ejecución, acceso a memoria y escritura de resultados— se realizan dentro de ese mismo ciclo.

## Características principales

- Arquitectura tipo RISC de un solo ciclo.
- Unidad de control completamente combinacional.
- ALU con soporte para operaciones aritmético-lógicas básicas.
- Banco de registros con doble puerto de lectura y un puerto de escritura.
- Memorias separadas para instrucciones y datos.
- Soporte para instrucciones tipo R, tipo I y salto simple.
- Componentes modulares con testbenches individuales.
- Verificación mediante simulación y análisis de señales en archivos `.vcd`.

## Estructura del proyecto

- `Procesador_RISC.sv`: módulo principal que conecta todos los componentes.
- Módulos individuales: `ALU`, `Control_Unit`, `RegisterBank`, `PC`, `InstructionMemory`, `DataMemory`, `Multiplexor`, `ShiftUnit`, `SumaC2`, entre otros.
- Testbenches: archivos `.sv` para pruebas funcionales de cada módulo y archivos `.vcd` para análisis en simuladores como GTKWave.

## Simulación

Cada módulo puede simularse por separado. Para simular el procesador completo, asegúrate de que todos los componentes estén correctamente conectados y que las instrucciones en memoria estén codificadas conforme a la arquitectura definida.
