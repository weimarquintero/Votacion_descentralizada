// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

/**
 * @title Votacion (Descentralizada)
 */

/*Smart Contract para un sistema de votación descentralizado*/
 contract Votacion {

    /*Objeto tipo estructura que guarda la propuesta: Una propuesta consta de un nombre (nombre
    de la propuesta) y un contador de votos (que ha recibido la propuesta).*/
    struct Propuesta {
        string nombre;
        uint256 votosTotales;
    }
    //Lista de propuestas
    Propuesta[] public propuestas;

    /*Propietario del contrato: Quien ejecuta por primera vez el contrato. Es quien puede añadir propuestas y direcciones a la whiteList*/
    address public propietario;

    //WhiteList
    mapping(address => bool) public whiteList;

    //Mapping para controlar que se vote solo una vez
    mapping(address => bool) public sufragantes;

    //Tiempo de ejecuccion total del contrato
    uint256 public tiempoVotacion;

    //Constructor
    constructor(uint256 _duraccionContrato) {
        propietario = msg.sender;
        tiempoVotacion = block.timestamp + (_duraccionContrato * 1 days);
    }

    //Validar que la address entregada no sea la Zero
    modifier validarAddress(address _address) {
        require(_address != address(0), "Address NO valida");
        _;
    }

    //Validar que solo el propietario ejecute las funciones de adicionar propuestas y sufragantes a la whiteList
    modifier soloPropietario() {
        require(msg.sender == propietario, "Solo el propietario puede ejecutar esta funcion");
        _;
    }
    
    //Validar que solo las personas dentro de la whiteList puedan votar
    modifier soloWhitelist() {
        require(whiteList[msg.sender], "Solo las personas autorizadas pueden votar");
        _;
    }

    //Validar que la persona no haya votado - puesto que solo se puede votar una sola vez
    modifier yaVoto() {
        require(!sufragantes[msg.sender], "Usted ya voto");
        _;
    }

    //Validar que se pueda votar solo dentro del tiempo estipulado en el contrato - para este caso 3 dias
    modifier soloDuranteVotacion() {
        require(block.timestamp <= tiempoVotacion, "El periodo de votacion ha finalizado");
        _;
    }

    //Adicionar direcciones a la whiteList - se valida que no sea la address Zero y que sea el propietario quien la ejecute
    function adicionarAddress(address _sufragante) public validarAddress(_sufragante) soloPropietario {
        whiteList[_sufragante] = true;
    }

    //Adicionar propuestas a la lista
    function adicionarPropuesta(string memory _propuesta) public soloPropietario {
        propuestas.push(Propuesta({nombre:_propuesta,votosTotales:0}));
    }

    //proceso de votación
    function votar(uint256 _indicePropuesta) public soloWhitelist soloDuranteVotacion yaVoto {
        propuestas[_indicePropuesta].votosTotales += 1;
        sufragantes[msg.sender] = true;
    }

    //Retornar propuesta
    function retornarPropuesta(uint256 _indicePropuesta) public view returns (string memory nombre, uint256 votosTotales) {
        Propuesta storage propuesta = propuestas[_indicePropuesta];
        return (propuesta.nombre, propuesta.votosTotales);
    }

    //funcion para retornar todas las propuestas
    function retornarPropuestas() public view returns (Propuesta[] memory) {
        Propuesta[] memory resultado = new Propuesta[](propuestas.length);
        for (uint256 i = 0; i < propuestas.length; i++) {
            resultado[i] = propuestas[i];
        }
        return resultado;
    }

    //Retornar cuantas propuestas se tienen
    function retornarCuantasPropuestas() public view returns (uint256) {
        return propuestas.length;
    } 
 }