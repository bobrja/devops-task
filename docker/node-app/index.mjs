import fs from 'fs'

fs.appendFile('my-file.txt', 'File was create Node.js', (err) => {
	if (err) throw err
	console.log('File was save')
})

setTimeout(() => console.log('END'), 30000)
