/* 
    JavaScript for View Dashboard
 */

function abrirModalEliminar(url) {
    // Asigna la URL de eliminación al botón de confirmación dentro del modal
    document.getElementById('btnConfirmarEliminarUrl').setAttribute('href', url);
    
    // Inicializa y muestra el modal de Bootstrap de forma programática
    var myModal = new bootstrap.Modal(document.getElementById('modalConfirmarEliminar'));
    myModal.show();
}

// Variables globales para el control del estado triple
let filasOriginales = null;
let columnaActual = -1;
let estadoClick = 0; // 0 = Original, 1 = Ascendente, 2 = Descendente

function ordenarTabla(columnaIdx) {
    const tabla = document.querySelector(".table");
    const tbody = tabla.querySelector("tbody");
    const filas = Array.from(tbody.querySelectorAll("tr"));
    
    // 1. Respaldar el orden inicial del servidor la primerísima vez que se hace clic
    if (!filasOriginales) {
        filasOriginales = [...filas];
    }
    
    // 2. Controlar el ciclo de estados (Resetear si cambia de columna)
    if (columnaActual !== columnaIdx) {
        columnaActual = columnaIdx;
        estadoClick = 1; // Primer clic en una nueva columna -> Ascendente
    } else {
        // Ciclo: 1 (Asc) -> 2 (Desc) -> 0 (Original) -> 1 (Asc)...
        estadoClick = (estadoClick + 1) % 3;
    }
    
    // 3. Evaluar el estado actual para aplicar la lógica correspondiente
    if (estadoClick === 0) {
        // ESTADO 0: Regresa a como estaba antes (Estado Original de la Base de Datos)
        filasOriginales.forEach(fila => tbody.appendChild(fila));
        columnaActual = -1; // Reseteamos el foco de la columna
        return;
    }
    
    // ESTADOS 1 y 2: Ordenamiento lógico
    filas.sort((filaA, filaB) => {
        let valA = filaA.cells[columnaIdx].innerText.trim();
        let valB = filaB.cells[columnaIdx].innerText.trim();
        
        // --- Ordenación Numérica (Precio y Stock) ---
        if (columnaIdx === 1 || columnaIdx === 2) {
            valA = parseFloat(valA.replace(/S\//g, '').replace(/unds/g, '').replace(/,/g, '').trim()) || 0;
            valB = parseFloat(valB.replace(/S\//g, '').replace(/unds/g, '').replace(/,/g, '').trim()) || 0;
            
            return estadoClick === 1 ? valA - valB : valB - valA;
        } 
        
        // --- Ordenación Alfabética (Nombre y Categoría) ---
        else {
            return estadoClick === 1 
                ? valA.localeCompare(valB, 'es', { sensitivity: 'base' })
                : valB.localeCompare(valA, 'es', { sensitivity: 'base' });
        }
    });
    
    // 4. Inyectar el resultado ordenado visualmente
    filas.forEach(fila => tbody.appendChild(fila));
}