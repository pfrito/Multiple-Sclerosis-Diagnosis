<script setup>
import { ref, onMounted } from 'vue'

const sabiasQue = ref([
  'Sabías que... La esclerosis múltiple es una enfermedad crónica del sistema nervioso central que afecta principalmente al cerebro y a la médula espinal. Se caracteriza por la destrucción progresiva de la mielina, la sustancia que recubre y protege las fibras nerviosas, lo que interfiere con la transmisión de los impulsos nerviosos.',
  'Sabías que... La esclerosis múltiple afecta a más de 2.3 millones de personas en todo el mundo. Si bien puede afectar a personas de cualquier edad, suele diagnosticarse entre los 20 y los 40 años, y las mujeres tienen más probabilidades de desarrollar la enfermedad que los hombres.',
  'Sabías que... Aunque la esclerosis múltiple no tiene cura, existen tratamientos disponibles que pueden ayudar a controlar los síntomas y retrasar la progresión de la enfermedad. Estos tratamientos incluyen medicamentos para reducir la inflamación y regular la respuesta inmunológica, terapia física y ocupacional, y cambios en el estilo de vida, como mantener una dieta saludable y hacer ejercicio regularmente.'
])

let randomNumber = ref(null)

onMounted(() => {
  randomNumber.value = Math.floor(Math.random() * 3);
})
</script>

<template>
  <div class="flex flex-col items-center">
    <div class="flex max-w-sm">
      <i>      <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M4 2h16a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2h-6.1l-3.7 3.71c-.2.19-.45.29-.7.29H9a1 1 0 0 1-1-1v-3H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2m8.19 3.5c-.89 0-1.6.18-2.14.54c-.55.36-.83.96-.78 1.65h1.97c0-.28.1-.49.26-.63c.2-.14.42-.21.69-.21c.31 0 .58.08.76.26c.18.17.27.39.27.69c0 .28-.08.53-.22.74c-.17.22-.38.4-.64.54c-.52.32-.86.6-1.07.84c-.19.24-.29.58-.29 1.08h2c0-.28.05-.5.14-.68c.09-.17.26-.32.52-.47c.46-.21.84-.49 1.13-.85c.29-.37.44-.76.44-1.2c0-.7-.27-1.26-.81-1.68c-.54-.41-1.29-.62-2.23-.62M11 12v2h2v-2z"></path></svg>
</i>
      <p>{{ sabiasQue[randomNumber] }}</p>
    </div>
  </div>
</template>
