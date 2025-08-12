Solidity

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract IDUR_Prototype_A_Dat {
    using SafeMath for uint256;

    // Mapping of model IDs to their respective data
    mapping (address => Model) public models;

    // Event emitted when a new model is added
    event NewModelAdded(address indexed _modelID, string _modelName);

    // Event emitted when new data is added to a model
    event NewDataAdded(address indexed _modelID, uint256 _dataPoint);

    // Event emitted when a model is updated
    event ModelUpdated(address indexed _modelID, string _newModelName);

    struct Model {
        string modelName;
        uint256[] dataPoints;
    }

    // Function to add a new model
    function addModel(string memory _modelName) public {
        address modelID = address(keccak256(abi.encodePacked(_modelName)));
        models[modelID].modelName = _modelName;
        emit NewModelAdded(modelID, _modelName);
    }

    // Function to add new data to a model
    function addData(address _modelID, uint256 _dataPoint) public {
        models[_modelID].dataPoints.push(_dataPoint);
        emit NewDataAdded(_modelID, _dataPoint);
    }

    // Function to update a model
    function updateModel(address _modelID, string memory _newModelName) public {
        models[_modelID].modelName = _newModelName;
        emit ModelUpdated(_modelID, _newModelName);
    }

    // Function to get a model's data points
    function getModelDataPoints(address _modelID) public view returns (uint256[] memory) {
        return models[_modelID].dataPoints;
    }
}