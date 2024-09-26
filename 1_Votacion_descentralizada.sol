// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Votacion (Descentralizada)
 */

/*Smart Contract para un sistema de votación descentralizado*/
 contract Votacion {

    /*Objeto tipo estructura que guarda la propuesta: Una propuesta consta de un nombre (nombre
    de la propuesta) y un contador de votos (que ha recibido la propuesta).*/
    struct Propuesta {
        string nombre;
        uint8 votosTotales;
    }

    /*Propietario del contrato: Quien ejecuta por primera vez el contrato. Es quien puede añadir propuestas y direcciones a la whiteList*/
    address public propietario;

    //WhiteList
    mapping(address => bool) public whiteList;

    //Mapping para controlar que se vote solo una vez
    mapping(address => bool) public sufragantes;

    //Lista de propuestas
    Propuesta[] public propuestas;

    //Tiempo de ejecuccion total del contrato
    uint256 public tiempoVotacion;

    //Constructor
    constructor(uint256 duraccionContrato) {
        propietario = msg.sender;
        tiempoVotacion = block.timestamp + (duraccionContrato * 1 days);
    }
 }