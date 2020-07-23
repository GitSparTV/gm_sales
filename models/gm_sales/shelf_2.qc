$modelname	"gm_sales/shelf_2.mdl"
$body main	"shelf_2.smd"
$staticprop
$surfaceprop	combine_metal
$cdmaterials	"models/gm_sales/"

$sequence idle	"shelf_2.smd"

$collisionmodel	"shelf_2_phys.smd"
{
	$automass
	$concave
}