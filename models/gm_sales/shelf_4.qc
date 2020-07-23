$modelname	"gm_sales/shelf_4.mdl"
$body main	"shelf_4.smd"
$staticprop
$surfaceprop	combine_metal
$cdmaterials	"models/gm_sales/"

$sequence idle	"shelf_4.smd"

$collisionmodel	"shelf_4_phys.smd"
{
	$automass
	$concave
}