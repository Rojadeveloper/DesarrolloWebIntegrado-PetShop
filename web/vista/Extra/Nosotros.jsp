<%-- 
    Document   : nosotros
    Created on : 13 jul. 2026
    Author     : RonaldoYNV & UI Refinement (Cyberpunk Dark Mode)
--%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nosotros - PetShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* --- ESTILOS NATIVOS EMPOTRADOS (Tema Cyberpunk Dark) --- */
        body {
            background-color: #0b0b0c;
            color: #ffffff; /* Texto general en blanco puro por defecto */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        /* Contenedor Principal con efecto de luces sutiles al fondo */
        .about-wrapper {
            background: radial-gradient(circle at 10% 20%, rgba(181, 95, 230, 0.05) 0%, transparent 40%),
                        radial-gradient(circle at 90% 80%, rgba(26, 27, 32, 0.8) 0%, transparent 50%);
            padding: 80px 0;
        }

        /* Tarjeta de Presentación Principal */
        .about-card {
            background-color: #121214;
            border: 1px solid #23252f;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.7);
            position: relative;
            overflow: hidden;
        }

        .about-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #b55fe6, #8b3dc7);
        }

        /* Badge estilo Premium */
        .badge-about {
            background: rgba(181, 95, 230, 0.15);
            color: #b55fe6;
            border: 1px solid rgba(181, 95, 230, 0.3);
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 20px;
        }

        /* Títulos de sección */
        .title-gradient {
            background: linear-gradient(135deg, #ffffff 30%, #b55fe6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
            letter-spacing: -1px;
        }

        /* El floro / Textos principales (Blanco suave para no cansar la vista) */
        .floro-text {
            color: #e2e8f0 !important; 
            font-size: 1.1rem;
            line-height: 1.8;
        }

        .floro-highlight {
            color: #ffffff !important;
            font-weight: 600;
            font-size: 1.15rem;
            border-left: 3px solid #b55fe6;
            padding-left: 15px;
            margin: 25px 0;
        }

        /* Imagen destacada lateral */
        .img-decorativa {
            border-radius: 20px;
            border: 2px solid #23252f;
            box-shadow: 0px 15px 35px rgba(0, 0, 0, 0.8);
            transition: transform 0.3s ease, border-color 0.3s ease;
        }

        .img-decorativa:hover {
            transform: scale(1.02);
            border-color: #b55fe6;
        }

        /* Tarjetas de características o pilares */
        .pilar-card {
            background: #1a1b20;
            border: 1px solid #2d313f;
            border-radius: 16px;
            padding: 25px;
            height: 100%;
            transition: all 0.3s ease;
        }

        .pilar-card:hover {
            transform: translateY(-5px);
            border-color: #b55fe6;
            box-shadow: 0px 8px 25px rgba(181, 95, 230, 0.15);
        }

        /* Forzar que los textos descriptivos dentro de las tarjetas sean muy claros y legibles */
        .pilar-card p {
            color: #cbd5e1 !important; 
            font-size: 0.95rem;
            line-height: 1.6;
        }

        .icon-box {
            width: 50px;
            height: 50px;
            background: rgba(181, 95, 230, 0.1);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #b55fe6;
            font-size: 1.5rem;
            margin-bottom: 15px;
        }

        /* Botón de acción al final */
        .btn-regresar {
            background-color: #b55fe6 !important;
            border: none;
            color: #ffffff !important;
            font-weight: 700;
            padding: 12px 30px;
            border-radius: 30px;
            transition: all 0.25s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-regresar:hover {
            background-color: #9b46cb !important;
            box-shadow: 0 0 15px rgba(181, 95, 230, 0.5);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <jsp:include page="/vista/Extra/Navbar.jsp" />

    <div class="about-wrapper">
        <div class="container">
            <div class="row align-items-center g-5">
                
                <%-- BLOQUE DE TEXTO CON EL BUEN FLORO --%>
                <div class="col-lg-7">
                    <div class="about-card">
                        <span class="badge-about">
                            🐾 ¿Quiénes somos?
                        </span>
                        
                        <h1 class="display-5 title-gradient mb-4">Revolucionando el Bienestar Animal</h1>
                        
                        <p class="floro-text">
                            En <span class="text-white fw-bold">PetShop</span> no vemos a las mascotas simplemente como animales de compañía; las entendemos como miembros legítimos, leales e irremplazables de la familia. Nos dedicamos en cuerpo y alma a proveer soluciones de nutrición, salud y diversión de alto nivel, fusionando el amor por los animales con un servicio tecnológico impecable.
                        </p>

                        <div class="floro-highlight">
                            "Nuestra misión es simple pero poderosa: asegurar que cada cola siga batiéndose con alegría, que cada ronroneo sea de absoluta paz y que cada compañero peludo tenga una vida plena y llena de energía."
                        </div>

                        <p class="floro-text mb-4">
                            Diseñamos esta plataforma pensando en la comodidad de tu hogar. Aquí podrás explorar un catálogo seleccionado minuciosamente por veterinarios y expertos en el área, garantizando productos libres de componentes nocivos y pensados exclusivamente para el óptimo desarrollo de sus pelajes, digestión y sistemas inmunes.
                        </p>
                        
                        <a href="${pageContext.request.contextPath}/catalogo" class="btn-regresar">
                            <i class="fa-solid fa-store"></i> Explorar el Catálogo
                        </a>
                    </div>
                </div>

                <%-- IMAGEN COMPLEMENTARIA --%>
                <div class="col-lg-5 text-center">
                    <img src="https://images.unsplash.com/photo-1544568100-847a948585b9?q=80&w=600&auto=format&fit=crop" 
                         alt="Perro feliz sonriendo" 
                         class="img-fluid img-decorativa">
                </div>
            </div>

            <%-- PILARES DE CÓMO FUNCIONA (LOS TRES PASOS) --%>
            <div class="row mt-5 pt-4 g-4">
                <div class="col-md-4">
                    <div class="pilar-card">
                        <div class="icon-box">
                            <i class="fa-solid fa-shield-cat"></i>
                        </div>
                        <h4 class="text-white mb-2">Calidad Testeada</h4>
                        <p>Cada accesorio, juguete y alimento pasa por un estricto control de calidad. Solo ofrecemos lo que le daríamos a nuestros propios amigos peludos.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="pilar-card">
                        <div class="icon-box">
                            <i class="fa-solid fa-truck-fast"></i>
                        </div>
                        <h4 class="text-white mb-2">Envíos Seguros</h4>
                        <p>Tu pedido se procesa al instante. Sabemos que su comida favorita no puede esperar, por eso aceleramos nuestros motores por ellos.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="pilar-card">
                        <div class="icon-box">
                            <i class="fa-solid fa-circle-heart"></i>
                        </div>
                        <h4 class="text-white mb-2">Atención Con Amor</h4>
                        <p>Nuestro equipo está compuesto al 100% por amantes de los animales. Ante cualquier duda, te atenderemos con empatía y calidez humana.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>