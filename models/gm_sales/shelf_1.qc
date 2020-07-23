$modelname	"gm_sales/shelf_1.mdl"
$body main	"shelf_1.smd"
$staticprop
$surfaceprop	combine_metal
$cdmaterials	"models/gm_sales/"

$sequence idle	"shelf_1.smd"

$collisionmodel	"shelf_1_phys.smd"
{
	$automass
	$concave
}