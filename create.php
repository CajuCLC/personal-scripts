<?php
require dirname(__DIR__) . '/vendor/autoload.php';

use OpenCloud\Rackspace;
use Guzzle\Http\Exception\BadResponseException;

$client = new Rackspace(Rackspace::US_IDENTITY_ENDPOINT, array(
    'username' => '{username}',
    'apiKey' => '{apiKey}',
        ));

$name = "test01";
$region = "DFW";

error_log($name);
error_log($region);

// Create the CBS volume.
$volumeService = $client->volumeService(null, $region);
$volume = $volumeService->volume();

$volume->create(array(
    'display_name' => $name,
    'size' => 50,
    'volume_type' => 'SSD',
    'bootable' => true,
    'imageRef' => '8a99dc02-68e4-4dec-ac6c-70d509dbe4a0'
));

$idboot=0;

// 3. Get volume list.
$volumes = $volumeService->volumeList();

foreach ($volumes as $volume) {
    /** @var $volume OpenCloud\Volume\Resource\Volume  **/
if ($volume->name()== $name) {
    PHP_EOL;
$idboot = $volume->id();
error_log($idboot);
}
}

// Create Compute service
$computeService = $client->computeService(null, $region);
// Get empty server
$server = $computeService->server();

// HERE THINGS GO WRONG!!

// Get CBS ID from the one just created. Calling it CBS Case 1.
$bootableVolume = $volumeService->volume($idboot);

// Selecting a CBS ID from the one already created. Calling it CBS Case 2.
// $bootableVolume = $volumeService->volume('65206a9c-19a0-41cc-8665-cdd67e0e51a7');

// FLAVOR GENERAL1-1
// $flavor = $computeService->flavor('general1-1'); // If you run this, we get error: PHP Warning:  error_log() expects parameter 1 to be string, object given.
// $flavor = 'general1-1'; // This one works if you use CBS Case 2. If it's Case 2 we get this: {"badRequest": {"message": "Invalid volume: volume '6a65fe47-87d3-425d-97a7-3cad726270fd' status must be 'available'. Currently in 'creating'", "code": 400}}

// FLAVOR COMPUTE1-15
// $flavor = $computeService->flavor('compute1-15'); // We get same error_log error as the other.
$flavor = 'compute1-15'; // With this we get (CBS Case 1 or 2): {"forbidden": {"message": "Policy doesn't allow compute_flavor:create:image_backed to be performed.", "code": 403}}

echo "<br><br>";
error_log($flavor, 0);

try {
    $response = $server->create(array(
        'name'     => $name,
        'imageId'  => '8a99dc02-68e4-4dec-ac6c-70d509dbe4a0',
        'flavorId' => $flavor,
        'volume'   => $bootableVolume
    ));
} catch (BadResponseException $e) {
    echo $e->getResponse();
}

echo '<br><br>The End!';
?>
