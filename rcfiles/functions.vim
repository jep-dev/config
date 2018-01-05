" Active highlight (hi/transient/low) plus stack below
function! Syn_at(...)
	let stack=[]
	for id in synstack(line("."),col("."))
		let stack+=[synIDattr(id,"name")]
	endfor
	let syn_0=synID(line("."),col("."),0)
	let syn_1=synID(line("."),col("."),1)
	echo 'Hi="' . synIDattr(syn_1,"name")
				\ . '", Trans="' . synIDattr(syn_0,"name")
				\ . '", Lo="' . synIDattr(synIDtrans(syn_1),"name") . '",'
	echo '   Stack: ' . join(stack, ' > ')
endfunction
