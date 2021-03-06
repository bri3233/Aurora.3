
/datum/artifact_effect/hurt
	effecttype = I_HURT
	effect_type = 5

/datum/artifact_effect/hurt/DoEffectTouch(var/mob/toucher)
	if(toucher)
		var/weakness = GetAnomalySusceptibility(toucher)
		if(iscarbon(toucher) && prob(weakness * 100))
			var/mob/living/carbon/C = toucher
			C << "<span class='danger'>A painful discharge of energy strikes you!</span>"
			C.adjustOxyLoss(rand(5,25) * weakness)
			C.adjustToxLoss(rand(5,25) * weakness)
			C.adjustBruteLoss(rand(5,25) * weakness)
			C.adjustFireLoss(rand(5,25) * weakness)
			C.adjustBrainLoss(rand(5,25) * weakness)
			C.apply_effect(25 * weakness, IRRADIATE, blocked = C.getarmor(null, "rad"))
			C.adjustNutritionLoss(50 * weakness)
			C.adjustHydrationLoss(50 * weakness)
			C.make_dizzy(6 * weakness)
			C.weakened += 6 * weakness

/datum/artifact_effect/hurt/DoEffectAura()
	if(holder)
		var/turf/T = get_turf(holder)
		for (var/mob/living/carbon/C in range(src.effectrange,T))
			var/weakness = GetAnomalySusceptibility(C)
			if(prob(weakness * 100))
				if(prob(10))
					C << "<span class='danger'>You feel a painful force radiating from something nearby.</span>"
				C.adjustBruteLoss(1 * weakness)
				C.adjustFireLoss(1 * weakness)
				C.adjustToxLoss(1 * weakness)
				C.adjustOxyLoss(1 * weakness)
				C.adjustBrainLoss(1 * weakness)
				C.updatehealth()

/datum/artifact_effect/hurt/DoEffectPulse()
	if(holder)
		var/turf/T = get_turf(holder)
		for (var/mob/living/carbon/C in range(effectrange, T))
			var/weakness = GetAnomalySusceptibility(C)
			if(prob(weakness * 100))
				C << "<span class='danger'>A wave of painful energy strikes you!</span>"
				C.adjustBruteLoss(3 * weakness)
				C.adjustFireLoss(3 * weakness)
				C.adjustToxLoss(3 * weakness)
				C.adjustOxyLoss(3 * weakness)
				C.adjustBrainLoss(3 * weakness)
				C.updatehealth()
