# Guía rápida: Simulación de **SystemVerilog** en **Vivado**

> **Objetivo**  
> Preparar un entorno de simulación en Vivado / XSIM para verificar tu diseño escrito en SystemVerilog.

---

## 1  |  Requisitos previos
| Recurso | Versión mínima | Nota |
|---------|----------------|------|
| **Vivado Design Suite** | 2021.1 o posterior | Incluye **XSIM** (simulador integrado). |
| **Licencia** | WebPACK o más | WebPACK basta para simulación. |
| **Archivos SV** | `*.sv`, `*.sva`, `*.svh` | Código fuente y testbench. |

---

## 2  |  Crear un nuevo proyecto

1. **Inicia Vivado** y selecciona **_Create Project_**.  
2. **Nombre y ubicación**: elige una carpeta limpia (p.ej. `~/projects/p1_sim/`).  
3. **Tipo de proyecto**:  
   - Marca **RTL Project**  
   - **Desactiva** la casilla _Do not specify sources at this time_ si vas a añadirlos ahora.  
4. **Añadir fuentes**  
   - Importa o crea tus archivos RTL (`*.sv`) y Testbench (`*_tb.sv`).  
   - Vivado detecta automáticamente la librería `work`.  
5. **Selecciona dispositivo** (familia o parte) o un **Board** si ya tienes uno definido.  
   > *XSIM no necesita target específico, pero Vivado requiere asignar uno.*

---

## 3  |  Configurar la simulación

1. En el **Flow Navigator**, abre **Settings → Simulation**.  
2. **Target Simulator**: selecciona **XSIM**.  
3. **Language Options**  
   - `Verilog-2001`  
   - **SystemVerilog** ✔️  
4. **Simulation Top Module Name**  
   - Escribe el nombre de tu **testbench** (p.ej. `p1_tb`).  
5. (Opcional) Ajusta el **Time Unit/Precision** (p.ej. `1ns / 1ps`).  
6. Aplica los cambios y guarda.
7. En **Sources → Simulation Sources → *(selecciona el archivo a simular con clic derecho)* → Set as Top**.

---

## 4  |  Compilar y ejecutar

1. En **Flow Navigator → Simulation → Run Simulation → Run Behavioral Simulation**.  
2. Vivado compila (`xvlog`) y elabora (`xelab`) automáticamente antes de lanzar `xsim`.  
3. Aparecerá la ventana **XSIM Waveform** con tu diseño cargado.


---