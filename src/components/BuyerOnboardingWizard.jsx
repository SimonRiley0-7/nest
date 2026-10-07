import React, { useState } from 'react';
import { X, CheckCircle, ChevronRight, ChevronLeft, User, DollarSign, MapPin, Sliders } from 'lucide-react';

export default function BuyerOnboardingWizard({ onClose, onComplete }) {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    name: 'Ananya Sharma',
    budgetMax: 15000000, // 1.5 Cr
    city: 'Bangalore',
    preferredBhk: '3BHK',
  });

  const totalSteps = 5;

  const handleNext = () => {
    if (step < totalSteps) setStep(step + 1);
    else onComplete(formData);
  };

  const handlePrev = () => {
    if (step > 1) setStep(step - 1);
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-md animate-fadeIn">
      <div className="glass-card max-w-lg w-full rounded-2xl p-6 space-y-6 border border-indigo-500/30">
        <div className="flex items-center justify-between border-b border-slate-800 pb-3">
          <div>
            <span className="text-xs text-indigo-400 font-bold uppercase tracking-wider">Buyer Preference Wizard</span>
            <h2 className="text-lg font-bold text-white">Step {step} of {totalSteps}</h2>
          </div>
          <button onClick={onClose} className="p-1 rounded-lg bg-slate-800 text-slate-400 hover:text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="w-full h-1.5 bg-slate-800 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-indigo-500 to-violet-500 transition-all duration-300"
            style={{ width: `${(step / totalSteps) * 100}%` }}
          />
        </div>

        <div className="space-y-4">
          {step === 1 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 1: Your Name</h3>
              <input
                type="text"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-indigo-500"
              />
            </div>
          )}

          {step === 2 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 2: Budget Range</h3>
              <div className="flex items-center justify-between text-xs text-slate-300">
                <span>Max Budget:</span>
                <span className="font-mono text-base font-bold text-indigo-400">
                  ₹{(formData.budgetMax / 10000000).toFixed(2)} Cr
                </span>
              </div>
              <input
                type="range"
                min="3000000"
                max="50000000"
                step="1000000"
                value={formData.budgetMax}
                onChange={(e) => setFormData({ ...formData, budgetMax: Number(e.target.value) })}
                className="w-full accent-indigo-500"
              />
            </div>
          )}

          {step === 3 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 3: City / Location</h3>
              <select
                value={formData.city}
                onChange={(e) => setFormData({ ...formData, city: e.target.value })}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-indigo-500"
              >
                <option>Bangalore</option>
                <option>Pune</option>
                <option>Mumbai</option>
                <option>Delhi NCR</option>
                <option>Hyderabad</option>
              </select>
            </div>
          )}

          {step === 4 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 4: Preferred BHK Layout</h3>
              <div className="grid grid-cols-4 gap-2">
                {['1BHK', '2BHK', '3BHK', '4BHK+'].map((bhk) => (
                  <button
                    key={bhk}
                    onClick={() => setFormData({ ...formData, preferredBhk: bhk })}
                    className={`py-2.5 rounded-xl font-bold text-xs border transition-all ${
                      formData.preferredBhk === bhk
                        ? 'bg-indigo-600 text-white border-indigo-500 shadow-md'
                        : 'bg-slate-900 text-slate-300 border-slate-800 hover:border-slate-700'
                    }`}
                  >
                    {bhk}
                  </button>
                ))}
              </div>
            </div>
          )}

          {step === 5 && (
            <div className="space-y-4 text-center py-2">
              <div className="w-12 h-12 rounded-full bg-indigo-500/20 text-indigo-400 mx-auto flex items-center justify-center">
                <CheckCircle className="w-6 h-6" />
              </div>
              <h3 className="font-bold text-white text-lg">Step 5: Setup Complete!</h3>
              <p className="text-xs text-slate-400 max-w-md mx-auto">
                Landing on home marketplace screen with custom recommendations matching {formData.preferredBhk} under ₹{(formData.budgetMax / 10000000).toFixed(2)} Cr in {formData.city}.
              </p>
            </div>
          )}
        </div>

        <div className="flex items-center justify-between pt-4 border-t border-slate-800">
          <button
            onClick={handlePrev}
            disabled={step === 1}
            className={`px-4 py-2 rounded-xl text-xs font-semibold flex items-center gap-1 ${
              step === 1 ? 'opacity-40 text-slate-600' : 'bg-slate-800 text-slate-200 hover:bg-slate-700'
            }`}
          >
            <ChevronLeft className="w-4 h-4" /> Back
          </button>
          <button
            onClick={handleNext}
            className="px-5 py-2.5 rounded-xl bg-gradient-to-r from-indigo-600 to-violet-600 hover:from-indigo-500 hover:to-violet-500 text-white font-bold text-xs shadow-lg flex items-center gap-1"
          >
            <span>{step === totalSteps ? 'Land on Marketplace' : 'Next Step'}</span>
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>
  );
}
