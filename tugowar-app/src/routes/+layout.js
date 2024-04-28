import {
  PUBLIC_OP_GARNET_TUGAWAR_ADDRESS,
  PUBLIC_OP_SEPOLIA_TUGAWAR_ADDRESS,
  PUBLIC_LOCAL_TUGAWAR_ADDRESS
 } from '$env/static/public';
/** @type {import('./$types').PageLoad} */
export function load({params, url, route}) {
  return {
    arenaAddress:{
      "op-garnet": PUBLIC_OP_GARNET_TUGAWAR_ADDRESS,
      "op-sepolia": PUBLIC_OP_SEPOLIA_TUGAWAR_ADDRESS,
      "local": PUBLIC_LOCAL_TUGAWAR_ADDRESS,
    },
    request: {
      href:url.href,
      origin:url.origin,
      hostname:url.hostname,
      route,
      params
    }
  }
}