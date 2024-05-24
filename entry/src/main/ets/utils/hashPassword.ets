import cryptoFramework from "@ohos.security.cryptoFramework";

function stringToUint8Array(str) {
  let arr = [];
  for (let i = 0, j = str.length; i < j; ++i) {
    arr.push(str.charCodeAt(i));
  }
  return new Uint8Array(arr);
}

function uint8ArrayToString(array) {
  let arrayString = '';
  for (let i = 0; i < array.length; i++) {
    arrayString += String.fromCharCode(array[i]);
  }
  return arrayString;
}

async function generateKeyPair() {
  let rsaGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
  let keyPair = await rsaGenerator.generateKeyPair();
  return keyPair;
}

async function encryptMessage(plainText, pubKey) {
  let cipher = cryptoFramework.createCipher("RSA1024|PKCS1");
  await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, pubKey, null);
  let input = {data: stringToUint8Array(plainText)};
  let encryptedData = await cipher.doFinal(input);
  return uint8ArrayToString(encryptedData.data);
}

async function decryptMessage(encryptedData, priKey) {
  let cipher = cryptoFramework.createCipher("RSA1024|PKCS1");
  await cipher.init(cryptoFramework.CryptoMode.DECRYPT_MODE, priKey, null);
  let input = {data: encryptedData};
  let decryptedData = await cipher.doFinal(input);
  return uint8ArrayToString(decryptedData.data);
}

export { generateKeyPair, encryptMessage, decryptMessage };