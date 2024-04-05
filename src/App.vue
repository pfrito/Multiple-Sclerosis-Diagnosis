<script setup>
import { ref, onMounted } from 'vue'

const sabiasQue = ref([
  'La esclerosis múltiple (EM) es una enfermedad crónica del sistema nervioso central que afecta el cerebro y la médula espinal.',
  'Se estima que más de 2,3 millones de personas en todo el mundo tienen esclerosis múltiple.',
  'La causa exacta de la esclerosis múltiple se desconoce, pero se cree que es el resultado de una combinación de factores genéticos y ambientales.',
  'La esclerosis múltiple generalmente se diagnostica en adultos jóvenes, entre los 20 y los 40 años de edad, aunque puede aparecer en cualquier etapa de la vida.',
  'No existe una cura para la esclerosis múltiple en la actualidad, pero hay tratamientos disponibles para controlar los síntomas y retrasar la progresión de la enfermedad.',
  'El pronóstico de la esclerosis múltiple varía para cada persona, pero la mayoría de las personas con EM tienen una esperanza de vida normal.'
])

let symptoms = ref(['espasmos', 'entumecimiento','debilidad muscular', 'vision borrosa', 'dificultad de coordinacion', 'habla arrastrada', 'incontinencia urinaria', 'vision doble', 'perdida de vision', 'fatiga persistente'])
let selectedSymptoms = ref([])
let randomNumber = ref(null)
let lumbarTest = ref(false);
let mriTest = ref(false);
let electroTest = ref(false);
let diagnosis = ref("");

onMounted(() => {
  randomNumber.value = Math.floor(Math.random() * 6);
})

function setLumbarTest(result) {
  lumbarTest.value = result
}
function setMriTest(result) {
  mriTest.value = result
}
function setElectroTest(result) {
  electroTest.value = result
}

function toggleSymptom(symptom) {
  if (selectedSymptoms.value.includes(symptom)) {
    selectedSymptoms.value = selectedSymptoms.value.filter((element) => {
      return element !== symptom
    })
  }
  else {
    selectedSymptoms.value.push(symptom);
  }
}

function submit() {
  let type = "";
  let gravedad = "";

  if (lumbarTest.value && selectedSymptoms.value.length >= 3) {
    diagnosis.value = "El paciente tiene Esclerosis Multiple\n";

    if ((selectedSymptoms.value.includes('entumecimiento') && selectedSymptoms.value.includes('debilidad muscular') && selectedSymptoms.value.includes('fatiga persistente')) && (!selectedSymptoms.value.includes('incontinencia urinaria') || !selectedSymptoms.value.includes('perdida de vision') || !selectedSymptoms.value.includes('habla arrastrada')) && mriTest.value && selectedSymptoms.value.length < 5) {
      type = "Esclerosis Multiple Remitente Recurrente";
    }
    else if ((selectedSymptoms.value.includes('espasmos') && selectedSymptoms.value.includes('vision doble') && selectedSymptoms.value.includes('dificultad de coordinacion')) && (!selectedSymptoms.value.includes('incontinencia urinaria') || !selectedSymptoms.value.includes('perdida de vision') || !selectedSymptoms.value.includes('habla arrastrada'))) {
      type = "Esclerosis Multiple Primaria Progresiva";
    }
    else if (mriTest.value && !electroTest.value && selectedSymptoms.value.includes('incontinencia urinaria') && selectedSymptoms.value.includes('perdida de vision') && selectedSymptoms.value.includes('habla arrastrada')) {
      type = "Esclerosis Multiple Secundaria Progresiva";
    }
    else {
      type = "Esclerosis Multiple Recurrente Remitente sin lesiones en RM cerebral";
    }

    diagnosis.value += `Tipo: ${type}\n`;

    if (type == "Esclerosis Multiple Remitente Recurrente" || "Esclerosis Multiple Recurrente Remitente sin lesiones en RM cerebral") {
      gravedad = "Leve"
    }
    if (type == "Esclerosis Multiple Primaria Progresiva") {
      gravedad = "Moderada"
    }
    if(type == "Esclerosis Multiple Secundaria Progresiva") gravedad = "Severa"

    diagnosis.value += `Gravedad: ${gravedad}\n`;

    if (gravedad == "Leve") {
      diagnosis.value += "Medicamentos: Copaxone, Esteroides\n"
    }
    else if (gravedad == "Moderada") {
      diagnosis.value += "Medicamentos: Fingolimod\n"
    }
    else diagnosis.value += "Medicamentos: Interferones, Esteroides\n"
  }
  else {
    diagnosis.value = "El paciente no tiene Esclerosis Multiple\n";
  }
}
</script>

<template>
  <div class="flex flex-col items-center gap-10 text-gray-700 p-4">
    <div class="flex items-center max-w-sm mt-4">
      <i class="mdi mdi-help rounded-full text-blue-700 bg-blue-100 text-3xl h-min px-3 py-2 mr-3"></i>
      <p>
        <span class="text-black font-semibold">Sabias que...</span>
        {{ sabiasQue[randomNumber] }}</p>
    </div>

    <div class="flex flex-col items-center w-full max-w-xl py-5 border-2 border-gray-200 rounded-sm">
      <h1 class="text-black font-semibold">
        <i class="mdi mdi-numeric-1-circle-outline"></i>
        cuáles son sus síntomas?
      </h1>
      <span class="text-lg my-5">Seleccione Síntomas</span>
      <div class="w-full flex flex-wrap justify-center gap-2 px-4 text-blue-700">
        <button v-for="symptom in symptoms" :key="symptom" class="bg-blue-100 rounded-full px-3 pb-1 transition-all ease-in-out duration-100" :class="{'bg-blue-600 text-blue-100': selectedSymptoms.includes(symptom)}" @click="toggleSymptom(symptom)"><span>{{ symptom }}</span></button>
      </div>
    </div>

    <div class="flex flex-col items-center w-full max-w-xl gap-4 py-5 border-2 border-gray-200 rounded-sm">
      <h1 class="text-black font-semibold">
        <i class="mdi mdi-numeric-2-circle-outline"></i>
        resultado de la punción lumbar
      </h1>
      <div class="flex bg-blue-100 rounded-full p-1 h-10 w-52 text-blue-700">
        <button class="w-full flex justify-center items-center pb-1 rounded-s-full transition-all ease-in-out duration-150" :class="{ 'bg-blue-600 text-blue-100': lumbarTest}" @click="setLumbarTest(true)">
          <span>Positivo</span>
        </button>
        <button class="w-full flex justify-center items-center pb-1 rounded-e-full transition-all ease-in-out duration-150" :class="{ 'bg-blue-600 text-blue-100': !lumbarTest}" @click="setLumbarTest(false)">
          <span>Negativo</span>
        </button>
      </div>
    </div>

    <div class="flex flex-col items-center w-full max-w-xl gap-4 py-5 border-2 border-gray-200 rounded-sm">
      <h1 class="text-black font-semibold">
        <i class="mdi mdi-numeric-3-circle-outline"></i>
        resultado de la resonancia magnética
      </h1>
      <div class="flex bg-blue-100 rounded-full p-1 h-10 w-52 text-blue-700">
        <button class="w-full flex justify-center items-center pb-1 rounded-s-full transition-all ease-in-out duration-150" :class="{ 'bg-blue-600 text-blue-100': mriTest}" @click="setMriTest(true)">
          <span>Positivo</span>
        </button>
        <button class="w-full flex justify-center items-center pb-1 rounded-e-full transition-all ease-in-out duration-150" :class="{ 'bg-blue-600 text-blue-100': !mriTest}" @click="setMriTest(false)">
          <span>Negativo</span>
        </button>
      </div>
    </div>

    <div class="flex flex-col items-center w-full max-w-xl gap-4 py-5 border-2 border-gray-200 rounded-sm">
      <h1 class="text-black font-semibold">
        <i class="mdi mdi-numeric-4-circle-outline"></i>
        resultado de la electromiografía
      </h1>
      <div class="flex bg-blue-100 rounded-full p-1 h-10 w-52 text-blue-700">
        <button class="w-full flex justify-center items-center pb-1 rounded-s-full transition-all ease-in-out duration-150" :class="{ 'bg-blue-600 text-blue-100': electroTest}" @click="setElectroTest(true)">
          <span>Positivo</span>
        </button>
        <button class="w-full flex justify-center items-center pb-1 rounded-e-full transition-all ease-in-out duration-150" :class="{ 'bg-blue-600 text-blue-100': !electroTest}" @click="setElectroTest(false)">
          <span>Negativo</span>
        </button>
      </div>
    </div>

    <button class="bg-blue-100 text-blue-700 hover:bg-blue-600 hover:text-blue-100  rounded-full px-4 pt-1 pb-2 uppercase transition-all ease-in-out duration-100" @click="submit">
      <span>Diagnostico</span>
    </button>

    <textarea
      class="bg-gray-100 border-2 border-gray-200 rounded-sm p-4 w-full max-w-md h-40 mb-4"
      readonly
      :value="diagnosis"
      placeholder="Diagnóstico..."
    ></textarea>
  </div>

  <footer style="background-color: #f5f5f5;" class="flex items-center justify-center border-t w-full py-5 text-gray-700 font-nunito">Made with <img src="./assets/pixel-art-heart.png" alt="pixel art heart" class="w-5 h-5 mx-1"> by<a href="https://github.com/pfrito" class="uppercase hover:text-black ml-1">Carlos</a></footer>

</template>
