PRESENTER=`az account show | jq -r .user.name`
ORGANIZATION=organization-goes-here
PROJECT=project-name-goes-here

echo "Please enter your Personal Access Token, followed by [ENTER] (Input will be hiden):"
read -s PAT
echo
echo "Please enter your Build Definition ID, followed by [ENTER]:"
read buildDef
echo
echo "Please enter your Release Definition ID, followed by [ENTER]:"
read releaseDef

function presenter() 
{
    local  presenter=$PRESENTER
    echo "$presenter"
}

function organization() 
{
    local  organization=$ORGANIZATION
    echo "$organization"
}

function project() 
{
    local  project=$PROJECT
    echo "$project"
}

function PAT() 
{
    local  PAT=$PAT
    echo "$PAT"
}

function buildDef() 
{
    local  buildDef=$buildDef
    echo "$buildDef"
}

function releaseDef() 
{
    local releaseDef=$releaseDef
    echo "$releaseDef"
}
