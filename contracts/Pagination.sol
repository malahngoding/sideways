// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Pagination {
    struct Todo {
        string text;
        string url;
        string media;
        bool isAnimated;
    }

    Todo[] todos;

    function concatenate(string memory a, string memory b)
        public
        pure
        returns (string memory)
    {
        return string(bytes.concat(bytes(a), " ", bytes(b)));
    }

    function create(
        string memory _text,
        string memory _url,
        string memory _media,
        bool _isAnimated
    ) public {
        todos.push(Todo(_text, _url, _media, _isAnimated));
    }

    function getLength() public view returns (uint256 count) {
        return todos.length;
    }

    function getBetween(uint256 _start, uint256 _count)
        public
        view
        returns (Todo[] memory)
    {
        Todo[] memory items = new Todo[](_count);
        uint256 endPointer = SafeMath.add(_start, _count);
        uint256 index = 0;
        for (uint256 i = _start; i < endPointer; i++) {
            Todo storage currentItem = todos[i];
            items[index] = currentItem;
            index++;
        }
        return items;
    }

    function getAt(uint256 _index)
        public
        view
        returns (
            string memory text,
            string memory url,
            string memory media,
            bool isAnimated
        )
    {
        Todo storage todo = todos[_index];
        return (todo.text, todo.url, todo.media, todo.isAnimated);
    }

    function update(
        uint256 _index,
        string memory _text,
        string memory _url,
        string memory _media,
        bool _isAnimated
    ) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
        todo.url = _url;
        todo.media = _media;
        todo.isAnimated = _isAnimated;
    }
}
