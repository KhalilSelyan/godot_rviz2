extends MeshInstance

var pointcloud = PointCloud.new()
var visualize_again = false
#var is_reseted = false

func _ready():
	pointcloud.subscribe("/map/pointcloud_map", true)

func _process(_delta):
	if not (pointcloud.is_new() or visualize_again):
		return

	var arr = []
	arr.resize(Mesh.ARRAY_MAX)
	var verts = PoolVector3Array()
#	var uvs = PoolVector2Array()
#	var normals = PoolVector3Array()
#	var indices = PoolIntArray()

	verts = pointcloud.get_pointcloud()

#	for vert in verts:
#		uvs.append(Vector2(clamp(vert.y*10.0,0,2000), 0))

	arr[Mesh.ARRAY_VERTEX] = verts
#	arr[Mesh.ARRAY_TEX_UV] = uvs
	mesh.clear_surfaces()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_POINTS, arr)
	visualize_again = false



func _on_CheckButton_toggled(button_pressed):

	visible = button_pressed
	if not visible:
#		is_reseted = true
		mesh.clear_surfaces()
	elif visible:
		visualize_again = true
#		is_reseted = false
	print(visible)
	print(visualize_again)