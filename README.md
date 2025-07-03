# Proyecto-3. Procesador RISC con Pipeline

**Estudiantes:**
- Fernandez Aguilar Randy Steve  
- Matarrita Hernandez Nayeli  
- Quiros Avila Karina  
- Tencio Valverde Yonaikel Fabricio

Este proyecto implementa un procesador RISC con arquitectura de pipeline en SystemVerilog. A diferencia del procesador uniciclo, este diseño divide la ejecución de instrucciones en múltiples etapas que operan en paralelo, aumentando la eficiencia y el rendimiento del sistema.

## Etapas del pipeline

El procesador cuenta con las cinco etapas típicas de una arquitectura RISC:

1. **IF (Instruction Fetch)**  
2. **ID (Instruction Decode)**  
3. **EX (Execute)**  
4. **MEM (Memory access)**  
5. **WB (Write Back)**

Entre cada etapa se han implementado registros de pipeline (`IF_ID`, `ID_EX`, `EX_MEM`, `MEM_WB`) que permiten el paso de datos y señales de control de una etapa a la siguiente.

## Características principales

- Arquitectura RISC segmentada en cinco etapas.
- Implementación modular de registros entre etapas.
- Unidad de detección de riesgos (Hazard Detection Unit).
- Unidad de reenvío de datos (Forwarding Unit).
- Simulación completa con testbenches por módulo.
- Análisis de funcionamiento mediante archivos `.vcd`.

## Estructura del proyecto

- `Pipeline/`: contiene todos los módulos de procesamiento e integración principal (`Procesador_RISC_PIPELINE.sv`).
- `Registros del Pipeline/`: módulos y testbenches de los registros entre etapas (`IF_ID.sv`, `EX_MEM_tb.sv`, etc.).
- `Unidades_Riesgos/`: incluye `Hazard_U.sv`, `forwardunit.sv` y sus testbenches.
- Otros módulos: ALU, Unidad de Control, Banco de Registros, Memorias, MUXes, etc.

## Simulación

Cada componente tiene su testbench correspondiente. Para validar el procesador completo, asegúrate de que las instrucciones en memoria estén alineadas a la lógica de pipeline y que las unidades de control de riesgos estén activas.

