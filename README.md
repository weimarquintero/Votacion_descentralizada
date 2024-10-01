# Votacion_descentralizada
Repositorio para el trabajo con la tarea de Ethereum (sistema de votación descentralizado) de la materia de Blockchain 2024-2.

**Contract Overview**

This is a Solidity contract named `Votacion` (Decentralized Voting System) that allows users to vote on proposals within a specified time frame.

**Structs and Variables**

* `Propuesta`: a struct to store a proposal with a `nombre` (name) and `votosTotales` (total votes).
* `propuestas`: an array to store all proposals.
* `propietario`: the contract's owner, who can add proposals and voters to the whitelist.
* `sufragantes`: a mapping to track which users have already voted.
* `whiteList`: a mapping to track which users are authorized to vote.
* `tiempoVotacion`: the total execution time of the contract.

**Functions**

* `adicionarDireccion`: adds a user to the whitelist (only accessible by the contract owner).
* `adicionarPropuesta`: adds a new proposal to the list (only accessible by the contract owner).
* `votar`: allows a user to vote on a proposal (only accessible by users in the whitelist, within the specified time frame, and only once).
* `retornarPropuesta`: returns a proposal's details (name and total votes).
* `retornarPropuestas`: returns all proposals.
* `retornarCuantasPropuestas`: returns the total number of proposals.

**Modifiers**

* `soloPropietario`: ensures that only the contract owner can execute certain functions.
* `soloWhitelist`: ensures that only users in the whitelist can vote.
* `yaVoto`: ensures that a user can only vote once.
* `soloDuranteVotacion`: ensures that voting can only occur within the specified time frame.
