function justifyRem(){
			document.documentElement.style.fontSize = document.documentElement.clientWidth/16 + 'px';
		}
		justifyRem();
		window.addEventListener('resize',justifyRem,false);