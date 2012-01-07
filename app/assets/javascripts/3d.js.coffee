# VARIABLES
# ---------

$container  = undefined
stats       = undefined
camera      = undefined
scene       = undefined
renderer    = undefined
mesh        = undefined
group       = undefined
light       = undefined
mouseX      = 0
mouseY      = 0
windowHalfX = window.innerWidth / 2
windowHalfY = window.innerHeight / 2

# HELPER
# ------

onDocumentMouseMove = (event) ->
  mouseX = (event.clientX - windowHalfX)
  mouseY = (event.clientY - windowHalfY)

changeX = 0
changeY = 0
changeZ = 0

onKeyPress = (event) ->
  code = event.keyCode || event.which

  # r
  if code == 114
    camera.position.x = camera.position.y = 0
    camera.position.z = 500
    changeX = changeY = changeZ = 0

  changeFactor = 2

  # X axis
  if code == 107 # k
    changeX = changeFactor
  if code == 108 # l
    changeX = -changeFactor

  # Y axis
  if code == 121 # y
    changeY = changeFactor
  if code == 104 # h
    changeY = -changeFactor

  # Z axis
  if code == 106 # j
    changeZ = -changeFactor
  if code == 110 # n
    changeZ = changeFactor

onKeyUp = (event) ->
  changeX = changeY = changeZ = 0

animate = ->
  # demo: requestAnimationFrame animate
  # presentation: requestAnimationFrame animate, renderer.domElement
  requestAnimationFrame animate, renderer.domElement
  render()
  stats.update()

render = ->
  camera.position.x += changeX
  camera.position.y += changeY
  camera.position.z += changeZ

  camera.position.x += (mouseX - camera.position.x) * 0.05
  camera.position.y += (mouseY - camera.position.y) * 0.05

  camera.lookAt scene.position
  renderer.render scene, camera


init = ->

  # INITIALISATION
  $container = $('#container')
  $(document).mousemove onDocumentMouseMove
  $(document).keypress onKeyPress
  $(document).keyup onKeyUp

  stats = new Stats()
  $stats = $(stats.domElement)
  $stats.css
    position: 'absolute'
    top: 0
  $container.append $(stats.domElement)

  # RENDERER
  renderer = new THREE.WebGLRenderer(antialias: true)
  renderer.setSize window.innerWidth, window.innerHeight
  $container.append $(renderer.domElement)
  renderer.clear()
  renderer.shadowMapEnabled = true

  # CAMERA
  camera = new THREE.PerspectiveCamera(20, window.innerWidth / window.innerHeight, 1, 10000)
  camera.position.z = 400

  scene = new THREE.Scene()

  light = new THREE.DirectionalLight 0xffffff
  light.position.set 170, 330, 160
  light.position.normalize()

  scene.add light

  axisLength = 350
  material = new THREE.LineBasicMaterial(color: 0xff0000)
  geometry = new THREE.Geometry()
  geometry.vertices.push new THREE.Vertex(new THREE.Vector3(-axisLength, 0, 0)), new THREE.Vertex(new THREE.Vector3(axisLength, 0, 0))
  line = new THREE.Line(geometry, material)
  scene.add line

  material = new THREE.LineBasicMaterial(color: 0x00ff00)
  geometry = new THREE.Geometry()
  geometry.vertices.push new THREE.Vertex(new THREE.Vector3(0, -axisLength, 0)), new THREE.Vertex(new THREE.Vector3(0, axisLength, 0))
  line = new THREE.Line(geometry, material)
  scene.add line

  material = new THREE.LineBasicMaterial(color: 0x0000ff)
  geometry = new THREE.Geometry()
  geometry.vertices.push new THREE.Vertex(new THREE.Vector3(0, 0, -axisLength)), new THREE.Vertex(new THREE.Vector3(0, 0, axisLength))
  line = new THREE.Line(geometry, material)
  scene.add line



  planeGeo = new THREE.PlaneGeometry(100, 300, 10, 10)
  planeMat = new THREE.MeshLambertMaterial(
    color: 0xdd2222
    shading: THREE.FlatShading
    vertexColors: THREE.VertexColors
  )
  plane = new THREE.Mesh(planeGeo, planeMat)
  scene.add plane

  cube = new THREE.Mesh(
    new THREE.CubeGeometry(50,50,50)
    new THREE.MeshLambertMaterial(
      color: 0x555555
      shading: THREE.FlatShading
      vertexColors: THREE.VertexColors
    )
  )
  cube.position.y = 0
  cube.castShadow = true
  scene.add(cube)

$ ->
  Detector.addGetWebGLMessage() unless Detector.webgl

  init()
  animate(20)
