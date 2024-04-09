<template>
    <div>
      <div v-if="!mostrarFormulario">
        <div class="membership-container">
          <h2 class="membership-title">Elige tu membresía</h2>
          <div class="membership-cards">
            <div v-for="membresia in membresias" :key="membresia.id" class="membership-card">
              <div class="card-header">
                <h3 class="card-title">{{ membresia.tipo }}</h3>
                <p class="card-price">{{ membresia.precio }} / mes</p>
              </div>
              <ul class="benefits-list">
                <li v-for="(beneficio, index) in membresia.beneficios" :key="index">{{ beneficio }}</li>
              </ul>
              <div class="additional-info">
                <p><strong>Duración:</strong> {{ membresia.duracion }}</p>
                <p><strong>Dispositivos simultáneos:</strong> {{ membresia.dispositivosSimultaneos }}</p>
                <p><strong>Calidad de reproducción:</strong> {{ membresia.calidadReproduccion }}</p>
              </div>
              <button class="subscribe-button" @click="mostrarFormulario = true">Suscribirse</button>
            </div>
          </div>
        </div>
      </div>
      <div v-else>
        <form @submit.prevent="submitForm" class="membership-form">
          <h2>Formulario de Suscripción</h2>
          <div v-if="submitted && formularioValido" class="success-message">
            ¡Gracias por suscribirte!
          </div>
          <div v-if="submitted && !formularioValido" class="error-message">
            Por favor, completa todos los campos correctamente.
          </div>
          <div class="form-group">
            <label for="name">Nombre:</label>
            <input type="text" id="name" v-model="nombre" required>
          </div>
          <div class="form-group">
            <label for="email">Correo electrónico:</label>
            <input type="email" id="email" v-model="email" required>
          </div>
          <div class="form-group">
            <label for="membresia">Tipo de membresía:</label>
            <select id="membresia" v-model="tipoMembresia" required>
              <option value="Basica">Membresía Básica</option>
              <option value="Estandar">Membresía Estándar</option>
              <option value="Premium">Membresía Premium</option>
            </select>
          </div>
          <div class="form-group">
            <label for="payment">Método de pago:</label>
            <input type="text" id="payment" v-model="metodoPago" required>
          </div>
          <button type="submit" class="submit-button">Comprar</button>
          <button type="button" @click="mostrarFormulario = false">Volver</button>
        </form>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        membresias: [
          { 
            id: 1, 
            tipo: 'Membresía Básica', 
            precio: '$30', 
            duracion: '1 mes',
            dispositivosSimultaneos: '1 dispositivo',
            calidadReproduccion: 'Estándar',
            beneficios: ['Acceso a contenido básico', 'Una pantalla a la vez']
          },
          { 
            id: 2, 
            tipo: 'Membresía Estándar', 
            precio: '$50', 
            duracion: '1 mes',
            dispositivosSimultaneos: '2 dispositivos',
            calidadReproduccion: 'Estándar',
            beneficios: ['Acceso a contenido estándar', 'Dos pantallas simultáneas', 'Descarga en dispositivos']
          },
          { 
            id: 3, 
            tipo: 'Membresía Premium', 
            precio: '$80', 
            duracion: '1 mes',
            dispositivosSimultaneos: '4 dispositivos',
            calidadReproduccion: '4K + HDR',
            beneficios: ['Acceso a contenido premium', 'Cuatro pantallas simultáneas', 'Descarga en 4 dispositivos']
          }
        ],
        nombre: '',
        email: '',
        tipoMembresia: '',
        metodoPago: '',
        mostrarFormulario: false,
        submitted: false,
        formularioValido: false
      };
    },
    methods: {
      submitForm() {
        // Validación simple del formulario
        if (this.nombre && this.email && this.tipoMembresia && this.metodoPago) {
          // Simulación de envío de formulario
          // Aquí podrías realizar una solicitud HTTP para enviar los datos a un servidor
          this.submitted = true;
          this.formularioValido = true;
        } else {
          this.submitted = true;
          this.formularioValido = false;
        }
      }
    }
  };
  </script>
      
      <style scoped>
      .membership-container {
        margin: 20px;
      }
      
      .membership-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
      }
      
      .membership-cards {
        display: flex;
        justify-content: space-between;
      }
      
      .membership-card {
        width: 30%;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        background-color: #f9f9f9;
      }
      
      .card-header {
        text-align: center;
        margin-bottom: 20px;
      }
      
      .card-title {
        font-size: 20px;
        font-weight: bold;
      }
      
      .card-price {
        font-size: 16px;
        color: #888;
      }
      
      .benefits-list {
        padding-left: 0;
        list-style: none;
        margin-bottom: 20px;
      }
      
      .benefits-list li {
        margin-bottom: 10px;
      }
      
      .additional-info p {
        margin-bottom: 5px;
      }
      
      .subscribe-button {
        background-color: #e50914;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
        font-weight: bold;
        transition: background-color 0.3s;
      }
      
      .subscribe-button:hover {
        background-color: #d10813;
      }
    
      membership-form {
      margin: 20px;
    }
    
    .form-title {
      color: #ff0000; /* Rojo */
    }
    
    .form-group {
      margin-bottom: 20px;
    }
    
    label {
      font-weight: bold;
    }
    
    input[type="text"],
    input[type="email"],
    select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ff0000; /* Rojo */
      border-radius: 5px;
    }
    
    .submit-button {
      background-color: #cc0000; /* Rojo */
      color: #fff;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
    }
    
    .submit-button:hover {
      background-color: #ff0000; /* Rojo oscuro */
    }
      </style>
      