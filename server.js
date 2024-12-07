const express = require('express');
const fs = require('fs');
const path = require('path');
const app = express();

// Middleware para manejar JSON
app.use(express.json());

// Rutas existentes para obtener los beyblades
app.get('/beyblades', (req, res) => {
  fs.readFile(path.join(__dirname, 'beyblades.json'), 'utf8', (err, data) => {
    if (err) {
      res.status(500).send('Error al leer la base de datos');
    } else {
      res.json(JSON.parse(data)); // Devuelve los datos en formato JSON
    }
  });
});


// Ruta para obtener un beyblade por nombre
app.get('/beyblades/name/:name', (req, res) => {
  const beybladeName = req.params.name; // Obtener el nombre del beyblade desde la URL
  fs.readFile(path.join(__dirname, 'beyblades.json'), 'utf8', (err, data) => {
    if (err) {
      res.status(500).send('Error al leer la base de datos');
    } else {
      const beyblades = JSON.parse(data); // Parsear los datos del archivo JSON
      const beyblade = beyblades.find(b => b.name.toLowerCase() === beybladeName.toLowerCase()); // Buscar el beyblade por nombre

      if (beyblade) {
        res.json(beyblade); // Si se encuentra el beyblade, devolverlo
      } else {
        res.status(404).send('Beyblade no encontrado'); // Si no se encuentra el beyblade, devolver un error 404
      }
    }
  });
});

// Inicia el servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

