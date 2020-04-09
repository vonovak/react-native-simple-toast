declare var SimpleToast: {
  // Toast duration constants
  SHORT: number;
  LONG: number;

  // Toast gravity constants
  TOP: string;
  BOTTOM: string;
  CENTER: string;

  show: (message: string, duration?: number, viewControllerBlacklist?: Array<string>) => void;

  showWithGravity: (
    message: string,
    duration: number,
    gravity: string,
    viewControllerBlacklist?: Array<string>
  ) => void;
};

export default SimpleToast;
