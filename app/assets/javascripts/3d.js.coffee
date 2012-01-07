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

changeX = null
changeY = null
changeZ = null

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

  #camera.position.x += (10*mouseX - camera.position.x) * 1.05
  #camera.position.y += (-5*mouseY - camera.position.y) * 0.05
  #if camera.position.z > 5000
  #  camera.position.z -= (mouseX - camera.position.x) * 0.01
  #else
  #  camera.position.z += (mouseX - camera.position.x) * 0.01
  camera.lookAt scene.position
  renderer.render scene, camera


init = ->

  # initialisation stuff
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
  #renderer.setClearColorHex(0xEEEEEE, 1.0)
  renderer.clear()
  renderer.shadowMapEnabled = true

  # CAMERA
  camera = new THREE.PerspectiveCamera(20, window.innerWidth / window.innerHeight, 1, 10000)
  camera.position.z = 400

  scene = new THREE.Scene()

  light = new THREE.SpotLight 0xffffff
  light.position.set 170, 330, 160
  light.position.normalize()
  light.castShadow = true

  scene.add light

  cube = new THREE.Mesh(
    new THREE.CubeGeometry(50,50,50)
    new THREE.MeshLambertMaterial(color: 0x555555)
  )
  cube.position.y = 0
  cube.castShadow = true
  cube.receiveShadow = true
  scene.add(cube)


  shadowMaterial = new THREE.MeshBasicMaterial(map: THREE.ImageUtils.loadTexture("/assets/shadow.png"))
  shadowGeo = new THREE.PlaneGeometry 300, 300, 1, 1

  # mesh = new THREE.Mesh shadowGeo, shadowMaterial
  # mesh.position.y = -200
  # mesh.position.x = 0
  # mesh.rotation.x = -90 * Math.PI / 180
  # scene.add mesh

  # geometry    = new THREE.IcosahedronGeometry 1
  # materials   = [new THREE.MeshLambertMaterial
  #                  color: 0xffffff
  #                  shading: THREE.FlatShading
  #                  vertexColors: THREE.VertexColors
  #               ]

  # group = THREE.SceneUtils.createMultiMaterialObject(geometry, materials)
  # group.position.x = 0
  # group.position.y = 50
  # group.rotation.x = -1.87
  # group.scale.set 200, 200, 200
  # scene.add group

$ ->
  Detector.addGetWebGLMessage() unless Detector.webgl

  init()
  animate(20)
