// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Votacion (Descentralizada)
 */

 contract Votacion {

    struct Propuesta {
        string nombre;
        uint8 votosTotales;
    }

    address public propietario;
    mapping(address => bool) public whiteList;
    mapping(address => bool) public sufragantes;
    Propuesta[] public propuestas;
    uint8 public tiempoVotacion;
 }