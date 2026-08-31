// 5 variantes — todas incluem a meta de 100 mil inscritos
// Usado nos workflows n8n (copiar para o no "Sortear comentario")

const COMMENT_VARIANTS = [
  'Me ajuda a bater a meta de 100 mil inscritos! Se inscrevam no canal ❤️',
  'Estamos rumo aos 100 mil inscritos — me ajuda se inscrevendo no canal? ❤️',
  'Quer me ajudar a bater a meta de 100K inscritos? Inscreva-se no canal ❤️',
  'Meta: 100 mil inscritos! Se ainda nao e inscrito, se inscreve no canal ❤️',
  'Me ajuda nessa meta de 100 mil inscritos se inscrevendo aqui no canal ❤️',
];

// Codigo do no n8n:
// const variants = [...];
// const item = $input.first().json;
// const commentText = variants[Math.floor(Math.random() * variants.length)];
// return [{ json: { ...item, commentText } }];

module.exports = { COMMENT_VARIANTS };
