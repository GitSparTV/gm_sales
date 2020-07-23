$modelname	"gm_sales/shelf_3.mdl"
$body main	"shelf_3.smd"
$staticprop
$surfaceprop	combine_metal
$cdmaterials	"models/gm_sales/"

$sequence idle	"shelf_3.smd"

$collisionmodel	"shelf_3_phys.smd"
{
	$automass
	$concave
}